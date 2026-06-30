# Typst Common

Use this for Typst source discovery and builds. Keep it operational; add special
cases only after a real task needs them.

## Official References

- Typst docs: https://typst.app/docs/
- Reference: https://typst.app/docs/reference/
- Syntax: https://typst.app/docs/reference/syntax/
- Styling: https://typst.app/docs/reference/styling/
- Modules/packages: https://typst.app/docs/reference/scripting/
- Paths/root: https://typst.app/docs/reference/foundations/path/
- System inputs: https://typst.app/docs/reference/foundations/sys/
- Page layout: https://typst.app/docs/reference/layout/page/
- Bibliography: https://typst.app/docs/reference/model/bibliography/
- Figures/tables/images: https://typst.app/docs/reference/model/figure/,
  https://typst.app/docs/reference/model/table/,
  https://typst.app/docs/reference/visualize/image/
- PNG export: https://typst.app/docs/reference/png/

## Minimal Workflow

- Prefer the repository build command.
- Find the entrypoint, imports/includes, template variables, page setup, fonts,
  bibliography, and assets before editing.
- Preserve existing `--root`, `--input`, `--font-path`, package paths, and page
  flags.
- Check `typst --version` and `typst compile --help` before relying on docs for
  CLI flags.
- If the dependency graph is unclear, use `typst compile --deps - main.typ
  main.pdf` or write deps to a temporary JSON file.
- If no repo command exists:

```sh
typst compile main.typ main.pdf
```

- For PNG deliverables, use native PNG export:

```sh
typst compile --format png --ppi 180 main.typ /tmp/agent-typesetting-review/job/page-{0p}.png
```

- For PDF deliverables, inspect rendered images from the final PDF.
