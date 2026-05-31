---
name: block
description: Add, edit, or revise a block in a LaTeX Beamer poster (beamerposter, gemini theme, etc.). TRIGGER whenever the user asks to modify poster content — add/remove/rewrite a block, tweak a figure, change wording in a poster.tex file, or any edit to a file matching poster*.tex or files under a posters/ directory. MUST run the full compile -> PNG -> visual review loop; do not just edit the .tex and stop. Use after /research-posters:setup has produced layout.md.
user_invocable: false
---

# Poster Block Skill

Create or revise ONE block (`\begin{block}` or `\begin{alertblock}`) in the poster, then run the compile -> PNG -> visual QA loop until the rendered poster looks correct.

## Prerequisites

- `/setup` must have been run (layout.md exists, poster compiles, baseline PNG exists).

## Input

The user describes the block:
- Block type (block / alertblock) — default to `block` unless user says "summary", "highlight", or similar, which suggests `alertblock`.
- Column (1, 2, or 3) — ask if not specified.
- Position in column (append / insert before existing block title "X") — default append.
- Title and content description.

If any of these are missing and you cannot reasonably infer them, use AskUserQuestion to collect them.

## Phase A: Create Block

### Step 1: Spawn poster-creator Agent

Use the Task tool to spawn the `poster-creator` agent with:
- Block description from user
- Path to main `.tex` file
- Path to `layout.md`
- Path to plugin's `context/GUIDELINES.md`
- Target column index + position directive
- Block type and title

The agent edits the main `.tex` file in place, inserting the new block into the correct column.

## Phase B: Compile

### Step 2: Compile

```bash
cd <poster_directory> && if [ -f compile.sh ]; then ./compile.sh; else pdflatex -interaction=nonstopmode poster.tex && pdflatex -interaction=nonstopmode poster.tex; fi 2>&1
```

### Step 3: Handle Compilation Errors

If compilation fails:
1. Extract error:
   ```bash
   grep "^!" <poster_directory>/poster.log | head -5
   ```
2. Re-spawn `poster-creator` with the original description + current block LaTeX + error message. Agent fixes the block in place.
3. Retry compilation.
4. After 2 failed attempts, revert the edit (use `git diff` / `git checkout -- poster.tex` if the file is clean, else manually remove the new block) and surface the error to the user.

## Phase C: Render PNG + Visual QA Loop

### Step 4: Render Full Poster PNG

Posters are single-page. Render at a readable resolution:

```bash
rm -f <poster_directory>/.poster-preview*.png
pdftoppm -png -r 120 <poster_directory>/poster.pdf <poster_directory>/.poster-preview
PNG_PATH=$(ls <poster_directory>/.poster-preview*.png | head -1)
```

Resolution notes:
- `-r 120` gives a readable full-poster image (~5600x4000 for a 118.9cm x 84.1cm poster) that Claude can inspect.
- Bump to `-r 150` if labels look too small to review. Do not exceed `-r 200` (file gets huge).

### Step 5: (Optional) Crop to Affected Column

For close inspection of the new block, also produce a column crop. Use `pdftoppm` crop flags based on column index N (1-indexed):

```bash
# Compute crop box from the poster width (approximate)
# Assumes 3 equal columns. Adjust if layout.md says otherwise.
TOTAL_W=$(pdfinfo <poster_directory>/poster.pdf | awk '/Page size/ {print int($3)}')
TOTAL_H=$(pdfinfo <poster_directory>/poster.pdf | awk '/Page size/ {print int($5)}')
COL_W=$((TOTAL_W / 3))
X=$(( (N-1) * COL_W ))
pdftoppm -png -r 150 -x $X -y 0 -W $COL_W -H $TOTAL_H <poster_directory>/poster.pdf <poster_directory>/.poster-col$N
COL_PNG=$(ls <poster_directory>/.poster-col${N}*.png | head -1)
```

Use the column crop when the reviewer needs more detail; the full PNG for overall layout.

### Step 6: Spawn poster-reviewer Agent

Use the Task tool to spawn `poster-reviewer` with:
- Full poster PNG path
- Column crop PNG path (if produced)
- Main `.tex` path and line range of the new/edited block
- Target column index
- Original block description

### Step 7: Process Review Feedback

**If ACCEPTABLE:** proceed to Phase D.

**If NEEDS_REVISION or BLOCKING:**
1. Re-spawn `poster-creator` with original description + current block LaTeX + reviewer feedback.
2. Agent edits the block in place.
3. Recompile (Step 2).
4. Re-render PNG (Step 4, and column crop in Step 5 if used).
5. Re-review (Step 6).
6. Up to 3 QA retries. After that, stop and surface issues to the user.

## Phase D: User Approval

### Step 8: Show Result

Display `.poster-preview-1.png` to the user via the Read tool. If a column crop was produced, show that too.

Ask: "Here's the poster with the new block. Approve, or request changes?"

### Step 9: Handle Response

**Approved:** done. Ready for next `/block`.

**Changes requested:**
1. Re-spawn `poster-creator` with the user's feedback.
2. Loop back to Step 2 (compile).

## Common Review Issues (reviewer will flag)

- **Column overflow** — block pushes content off the bottom of the column (fix: cut content, shrink figures, reduce itemize spacing)
- **Text too small/dense** — unreadable at poster viewing distance (fix: larger font, less content)
- **Figure overflow** — `\includegraphics` wider than the column
- **TikZ collisions** — overlapping nodes, floating arrows
- **Dashes in text** — `--` or `---` (blocking; hook also catches this at write time)
- **Inconsistent block heights** in a column — one block dramatically taller than siblings
- **White-space imbalance** — column ends with lots of empty space while others are full

## Notes

- Each `/block` invocation creates or revises exactly ONE block.
- The `poster-creator` agent edits `poster.tex` in place; there is no file-per-block convention (unlike `/slide`).
- Resolution `-r 120` full + `-r 150` column-crop is the sweet spot for visual QA without blowing up context.
- The poster dash hook blocks `--`/`---` at write time; the reviewer also double-checks.
