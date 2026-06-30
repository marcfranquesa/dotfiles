---
name: typesetting
description: Work on LaTeX, Typst, and PDF typeset artifacts when source edits, builds, rendered pages, or visual-layout QA matter. Use for posters, Beamer slides, Typst files, and regular PDF documents that need build/render verification. Do not use for generic PDF text extraction or non-typeset PDF review.
---

# Typesetting

Use this as a small router plus a hard render-and-inspect gate. Load only the
reference files needed for the current artifact.

## Core Contract

1. Inspect local guidance and build files.
2. Identify the source owner and artifact type from context, not just extension.
3. Edit the owning source or asset only.
4. Build from current source, or prove a watcher rebuilt after the edit.
5. Render relevant current output pages to images.
6. Visually inspect those images before reporting done.
7. Report build command or watcher proof, output path, pages/images inspected,
   and checks skipped.

Compile success alone is never a done signal for this skill.

## Routing

- LaTeX source/build work: read `references/latex-common.md`.
- Typst source/build work: read `references/typst-common.md`.
- Any user-visible source, layout, asset, bibliography, style, or output change:
  also read `references/visual-qa.md`.

If the artifact type is ambiguous and the next edit could use the wrong build
path or wrong page-selection rule, resolve that from local files before editing.

## Review Artifacts

Write temporary renders under `/tmp/agent-typesetting-review/` unless the
project or user requests another location. Use fresh or cleared output paths so
old previews cannot be mistaken for current verification.

Do not add scripts or extra references until repeated use shows they are needed.
Prefer project build commands, `latexmk`, `typst compile`, Typst native PNG
export when the deliverable is PNG, and `pdftoppm` for PDF-to-image review.
