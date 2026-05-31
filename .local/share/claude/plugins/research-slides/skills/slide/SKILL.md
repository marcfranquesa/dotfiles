---
name: slide
description: Generate a single slide with mandatory visual QA. Use after /setup to create slides one at a time with user approval.
user_invocable: true
---

# Slide Skill

Generate one slide with mandatory visual QA loop and user approval.

## Prerequisites

- `/setup` must have been run first (layout.md must exist)
- Presentation must compile successfully

## Input

User describes the slide they want:
- Topic and key points
- Optional: specific name for the file (e.g., "motivation")

## Phase A: Create Slide

### Step 1: Determine Slide Number

Count existing `\input{slides/...}` lines in main.tex to determine the next slide number (NN, zero-padded to 2 digits).

### Step 2: Refresh Citation Keys

Re-read `bibliography.bib` to get current citation keys. The layout.md snapshot may be stale if previous slides added citations.

### Step 3: Spawn slide-creator Agent

Use the Task tool to spawn the slide-creator agent with:
- Slide description from user
- File path: `slides/NN-name.tex` (derive name from user input or topic)
- Path to `layout.md`
- Path to plugin's `context/GUIDELINES.md`
- Path to `bibliography.bib` + fresh list of existing citation keys
- Constraint reminder: exactly ONE `\begin{frame}...\end{frame}` per file
- Constraint reminder: if adding new citations, append bibtex entry to bibliography.bib first

The agent creates `slides/NN-name.tex` (and optionally appends to bibliography.bib).

## Phase B: Compile + Handle Errors

### Step 4: Insert \input Line

Add `\input{slides/NN-name}` to main.tex **before the references frame**.

Find the references frame (typically `\begin{frame}[allowframebreaks]{References}` or similar) and insert the \input line before it.

### Step 5: Compile

```bash
# Prefer compile.sh if available, otherwise use pdflatex fallback
cd <presentation_directory> && if [ -f compile.sh ]; then ./compile.sh; else pdflatex -interaction=nonstopmode main.tex && bibtex main && pdflatex -interaction=nonstopmode main.tex && pdflatex -interaction=nonstopmode main.tex; fi 2>&1
```

**Compilation approach:**
- First preference: `compile.sh` (user's custom script)
- Fallback: triple pdflatex + bibtex for proper bibliography resolution

### Step 6: Handle Compilation Errors

If compilation fails:
1. Extract error from log:
   ```bash
   grep "^!" main.log | head -5
   ```
2. Re-spawn slide-creator with:
   - Original description
   - Current .tex content
   - Error message
3. Agent overwrites `slides/NN-name.tex` with fix
4. Retry compilation (do NOT re-insert \input line - it's already there)
5. If still failing after 2 attempts:
   - Remove `\input{slides/NN-name}` line from main.tex
   - Delete `slides/NN-name.tex`
   - Show error to user and stop

## Phase C: Visual QA Loop

### Step 7: Find Slide's Last Page

Scan PDF backward from end to find the first non-references page:

```bash
TOTAL_PAGES=$(pdfinfo main.pdf | grep Pages | awk '{print $2}')
EXTRACT_PAGE=$TOTAL_PAGES
for p in $(seq $TOTAL_PAGES -1 1); do
  PAGE_TEXT=$(pdftotext -f $p -l $p main.pdf - 2>/dev/null)
  if ! echo "$PAGE_TEXT" | head -5 | grep -qE "^\s*References\s*$"; then
    EXTRACT_PAGE=$p
    break
  fi
done
echo "Extracting page $EXTRACT_PAGE"
```

This handles:
- Multi-page bibliographies (scans backward past all reference pages)
- Empty bibliographies (fallback to last page)
- Overlays (extracts final overlay appearance)

### Step 8: Extract PNG

```bash
rm -f /tmp/slide*.png
pdftoppm -png -r 200 -f $EXTRACT_PAGE -l $EXTRACT_PAGE main.pdf /tmp/slide
PNG_PATH=$(ls /tmp/slide*.png | head -1)
```

### Step 9: Spawn slide-reviewer Agent

Use the Task tool to spawn the slide-reviewer agent with:
- PNG path: $PNG_PATH
- Source path: `slides/NN-name.tex`
- Original slide description

### Step 10: Process QA Feedback

Based on reviewer output:

**If ACCEPTABLE:**
- Proceed to Phase D (user approval)

**If NEEDS_REVISION or BLOCKING:**
1. Re-spawn slide-creator with:
   - Original description
   - Current .tex content
   - Reviewer's feedback and suggested fixes
2. Agent overwrites `slides/NN-name.tex`
3. Recompile (Step 5 - do NOT re-insert \input)
4. Re-extract PNG (Step 8)
5. Re-review (Step 9)
6. Up to 3 QA retries
7. If still failing after 3 retries:
   - Show issues to user
   - Ask how to proceed (continue anyway / manual fix / delete slide)

## Phase D: User Approval

### Step 11: Show Result to User

Display the PNG to the user using the Read tool (it can display images).

Ask: "Here's the slide. Do you approve it, or would you like changes?"

### Step 12: Handle User Response

**If user approves:**
- Done! Report success
- Ready for next `/slide` command

**If user requests changes:**
1. Re-spawn slide-creator with:
   - Original description
   - Current .tex content
   - User's specific feedback
2. Agent overwrites `slides/NN-name.tex`
3. Loop back to **Step 5** (compile) - NOT Step 4 (\input already present)
4. Continue through QA and back to user approval

## File Naming Convention

Format: `NN-slug.tex` where:
- `NN` = two-digit sequence number (01, 02, 03...)
- `slug` = user-provided name or derived from topic (lowercase, hyphenated)

Examples:
- `01-motivation.tex`
- `02-background.tex`
- `03-our-method.tex`

## Notes

- Each slide file contains exactly ONE `\begin{frame}...\end{frame}`
- TikZ diagrams are inlined in the slide file (no separate directory)
- The \input line is inserted once and stays in place during revisions
- Bibliography entries may be appended by slide-creator if new citations are needed
- The QA loop is automatic; user only sees the final result for approval
