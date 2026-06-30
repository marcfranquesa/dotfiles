# Visual QA

Use this only after user-visible source, layout, asset, bibliography, style, or
output changes.

## Gate

1. Build current source, or prove a watcher rebuilt after the edit.
2. Render relevant current output pages to fresh images.
3. Inspect the images, not just source or logs.
4. Report build command or watcher proof, output path, rendered pages/images,
   and checks skipped.

Compile success is not enough.

## Page Selection

- Posters: inspect every poster page.
- Beamer: inspect every affected frame page, including overlays.
- Regular documents: inspect changed pages plus neighbors when pagination,
  floats, tables, figures, or global style may shift.
- Global layout, font, theme, template, preamble, or page-geometry changes:
  inspect more pages.

## Commands

```sh
mkdir -p /tmp/agent-typesetting-review/job
pdftoppm -png -r 180 output.pdf /tmp/agent-typesetting-review/job/page
pdftoppm -png -r 180 -f 4 -l 6 output.pdf /tmp/agent-typesetting-review/job/page
```
