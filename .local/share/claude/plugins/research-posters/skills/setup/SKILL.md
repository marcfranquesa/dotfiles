---
name: setup
description: Initialize a LaTeX Beamer poster for block generation. Use when starting work on a new poster. Discovers theme, columns, macros, preamble, and produces layout.md.
user_invocable: true
---

# Poster Setup Skill

Discover LaTeX poster template structure and collect user preferences to create `layout.md`.

## Workflow

### Step 1: Get Poster Path

If the user did not provide a path, ask via AskUserQuestion for the poster directory (the folder containing `poster.tex` or similar).

### Step 2: Read Template Files

Read:
- `poster.tex` (or the main `.tex` file if named differently — detect via Glob `*.tex` at the top level)
- `preamble.tex` if it exists
- `compile.sh` or `Makefile` if present
- `figures/` directory listing (Glob `figures/**` — useful to know what images exist)

### Step 3: Discover Template Info

Extract from the main `.tex` file:
- **Document class**: typically `\documentclass[final]{beamer}`
- **Poster package**: `beamerposter` options (size, width, height, scale)
- **Theme / color theme**: `\usetheme{...}`, `\usecolortheme{...}` (e.g., `gemini`)
- **Column structure**: count `\colwidth` / `\separatorcolumn` / `\begin{column}` patterns. Most posters use 3 equal columns with separators.
- **Block macros**: which block environments are used (`block`, `alertblock`, custom)
- **Color commands / theme colors**
- **Custom macros**: `\newcommand`, `\tikzset` styles (e.g., `flowbox`, `base`, `dedge`)
- **Heading macros** if the theme provides them (e.g., `\heading{...}`)
- **Compilation command**: from `compile.sh` if present, otherwise default to `pdflatex` (see Step 7)

### Step 4: Enumerate Existing Blocks

Scan the main `.tex` file for `\begin{block}{Title}` and `\begin{alertblock}{Title}`. For each block, record:
- Column index (1-based, left to right)
- Block type (block vs alertblock)
- Title
- Approximate line range

List them for the user and ask via AskUserQuestion:
- "I found these existing blocks: [list]. Should I keep them as-is, or remove them so we start fresh?"

### Step 5: Collect User Preferences

Use AskUserQuestion:

1. **Style examples**: "Paste any example LaTeX or block you want me to mimic, or provide file paths."
2. **Content density**: sparse (lots of whitespace) / balanced / dense.
3. **Color usage**: minimal / moderate highlights / colorful.
4. **Poster topic**: one-sentence summary of what the poster is about.
5. **Venue / deadline** (optional but useful context).

### Step 6: Handle Block Removal

If the user confirmed removal in Step 4, edit the main `.tex` to delete those block environments (keep columns, title, footer intact).

### Step 7: Test Compilation

Run the compilation command to verify the setup works and to establish a baseline PDF:

```bash
cd <poster_directory> && if [ -f compile.sh ]; then ./compile.sh; else pdflatex -interaction=nonstopmode poster.tex && pdflatex -interaction=nonstopmode poster.tex; fi
```

(If the main file is not `poster.tex`, substitute its name. Posters typically do not need `bibtex` unless a `.bib` file exists.)

### Step 8: Generate Baseline PNG

Render the poster PDF to PNG (posters are 1 page):

```bash
pdftoppm -png -r 120 <poster_directory>/poster.pdf <poster_directory>/.poster-preview
```

Confirm that `<poster_directory>/.poster-preview-1.png` (or similar) was created. This baseline is used by `/block` for visual QA.

Add `.poster-preview*.png` to `.gitignore` if a `.gitignore` exists and the pattern is not already there.

### Step 9: Write layout.md

Create `<poster_directory>/layout.md`:

```markdown
# Poster Layout

## Template Information

### Document Class & Package
- Class: \documentclass[final]{beamer}
- Poster package: beamerposter [size=..., width=..., height=..., scale=...]
- Theme: gemini (or discovered)
- Color theme: gemini (or discovered)

### Column Structure
- Number of columns: 3 (or discovered)
- `\colwidth` = 0.3\paperwidth (or discovered)
- `\sepwidth` = 0.025\paperwidth (or discovered)

### Block Environments
- `\begin{alertblock}{Title}...\end{alertblock}` — highlighted blocks
- `\begin{block}{Title}...\end{block}` — standard blocks
- `\heading{...}` — in-block subheadings (if theme provides)

### Colors
[List discovered color commands]

### Custom Macros / TikZ Styles
[List `\newcommand`, `\tikzset{...}` styles such as flowbox, base, dedge]

### Compilation
```bash
[compilation command]
```

### Baseline preview
`.poster-preview-1.png`

## Existing Blocks

| Col | Type | Title | Lines |
|-----|------|-------|-------|
| 1 | alertblock | Summary | 108-147 |
| ... | ... | ... | ... |

## User Preferences

### Style Examples
[Paste examples or "None provided"]

### Preferences
- Content density: [user choice]
- Color usage: [user choice]

### Poster Topic
[One-sentence summary]

### Venue / Deadline
[Optional]
```

## Output

Report:
1. Template discovered (class, package options, theme, columns)
2. Existing blocks enumerated
3. Compilation verified
4. Baseline PNG created at `.poster-preview-1.png`
5. `layout.md` written
6. Ready to run `/block` to add or revise blocks

## Notes

- The `layout.md` file is read by the `poster-creator` agent on every `/block` invocation.
- Posters are single-page PDFs. The full-page PNG is what the reviewer inspects.
- Column assignment is explicit — user tells `/block` which column (1, 2, or 3) to place a new block in.
