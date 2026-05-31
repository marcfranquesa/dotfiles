---
name: setup
description: Initialize a LaTeX Beamer presentation for slide generation. Use when starting work on a new presentation. Discovers template structure, collects user preferences via Q&A, and creates layout.md.
user_invocable: true
---

# Setup Skill

Discover LaTeX template structure and collect user preferences to create `layout.md`.

## Workflow

### Step 1: Get Presentation Path

If the user didn't provide a path, ask for the presentation directory path using AskUserQuestion.

### Step 2: Read Template Files

Read the following files from the presentation directory:
- `main.tex` - main document structure
- `preamble.tex` - custom commands, colors, macros
- `compile.sh` or check for `Makefile` - compilation command
- Any existing slides in `slides/` directory

### Step 3: Discover Template Info

Extract from the preamble and main.tex:
- **Colors**: Look for `\definecolor`, `\newcommand{\red}`, etc.
- **Macros**: Look for `\newcommand`, `\renewcommand`, `\DeclareMathOperator`
- **Frame structure**: How frames are defined (title page structure, reference frame)
- **Compilation**: Extract command from compile.sh or infer from document class

### Step 3.5: Check Document Class Options

Examine the `\documentclass` line in main.tex:

1. **If options already specified** (e.g., `\documentclass[8pt, aspectratio=169]{beamer}`):
   - Extract and record the options
   - No changes needed

2. **If bare** `\documentclass{beamer}` **with no options**:
   - Use AskUserQuestion to ask the user:
     - **Aspect ratio**: "16:9 (modern widescreen, recommended)" vs "4:3 (traditional)"
     - **Font size**: "8pt (recommended for dense slides)" vs "11pt (larger, fewer items per slide)"
   - Or if you want to proceed quickly, default to `[8pt, aspectratio=169]` which is standard for modern presentations

3. **Apply the options** by editing main.tex:
   ```latex
   \documentclass[8pt, aspectratio=169]{beamer}
   ```

### Step 4: Check for Existing Slides

Look for `\input{slides/...}` lines in main.tex. If content frames exist (other than title/references):
- List them for the user
- Ask via AskUserQuestion: "I found these existing frames: [list]. Should I remove them as placeholders before we start fresh?"

### Step 5: Create slides/ Directory

```bash
mkdir -p <presentation_directory>/slides
```

### Step 6: Collect User Preferences

Use AskUserQuestion to gather:

1. **Style examples** (optional):
   - "Do you have example slides or LaTeX snippets showing your preferred style? If so, paste the LaTeX or provide file paths."

2. **Preferences**:
   - Color usage preference (minimal colors / moderate highlights / colorful)
   - Content density (sparse with lots of whitespace / moderate / dense)
   - Diagram style if applicable (simple boxes and arrows / detailed technical diagrams)

3. **Presentation topic**:
   - "What is this presentation about? (one sentence summary)"

### Step 7: Handle Placeholder Removal

If the user confirmed placeholder removal in Step 4:
- Edit main.tex to remove those `\input{slides/...}` lines
- Keep the title frame and references frame intact

### Step 8: Test Compilation

Run the compilation command to verify the setup works:

```bash
cd <presentation_directory> && if [ -f compile.sh ]; then ./compile.sh; else pdflatex -interaction=nonstopmode main.tex && bibtex main && pdflatex -interaction=nonstopmode main.tex && pdflatex -interaction=nonstopmode main.tex; fi
```

This creates the initial PDF (used as baseline for page-diff later).

### Step 9: Read Bibliography

If `bibliography.bib` exists:
- Read it and extract all citation keys (the `@article{key,` or `@inproceedings{key,` identifiers)
- List them for reference by the slide-creator agent

### Step 10: Write layout.md

Create `<presentation_directory>/layout.md` with all discovered information:

```markdown
# Presentation Layout

## Template Information

### Document Class
- **Options**: [8pt, aspectratio=169] (or whatever was discovered/set)
- **Aspect ratio**: 16:9 / 4:3
- **Font size**: 8pt / 11pt

### Colors
[List discovered color commands and their definitions]

### Custom Macros
[List useful macros from preamble]

### Frame Structure
[Describe how frames are structured - columns, labels, etc.]

### Compilation
```bash
[compilation command]
```

## Bibliography

- **File**: bibliography.bib
- **Existing citations**: [key1, key2, key3, ...]

## User Preferences

### Style Examples
[Paste any examples the user provided, or "None provided"]

### Preferences
- **Color usage**: [user's choice]
- **Content density**: [user's choice]
- **Diagram style**: [user's choice or "N/A"]

### Presentation Topic
[User's one-sentence summary]
```

## Output

After completing setup, report:
1. Template discovered successfully
2. Colors and macros found
3. Compilation verified (or any warnings)
4. `layout.md` created at: `<path>`
5. Ready to use `/slide` to create slides

## Notes

- The `layout.md` file will be read by the slide-creator agent for every slide
- Bibliography citations are refreshed before each slide creation (layout.md snapshot may go stale)
- No `front_matter_pages` tracking needed - the /slide skill uses page-count diff to locate new slides
