# LaTeX Common

Use this for LaTeX source discovery and builds. Keep it operational; add special
cases only after a real task needs them.

## Official References

- LaTeX Project docs: https://www.latex-project.org/help/documentation/
- LaTeX2e for authors: https://www.latex-project.org/help/documentation/usrguide.pdf
- Classes/packages: https://www.latex-project.org/help/documentation/clsguide.pdf
- Font selection: https://www.latex-project.org/help/documentation/fntguide.pdf
- latexmk: https://ctan.org/pkg/latexmk
- Beamer: https://ctan.org/pkg/beamer
- Poster classes: https://ctan.org/pkg/beamerposter and https://ctan.org/pkg/tikzposter
- Graphics/bibliography: https://ctan.org/pkg/graphicx and https://ctan.org/pkg/biblatex

## Minimal Workflow

- Prefer the repository build command.
- Find the entrypoint, include chain, preamble, bibliography setup, and output
  PDF before editing.
- Edit the owning source file, not generated output.
- Preserve the existing engine unless local source or docs require a switch.
- If no repo command exists, use `latexmk` with the existing engine:

```sh
latexmk -pdf <entrypoint>.tex
latexmk -pdfxe <entrypoint>.tex
latexmk -pdflua <entrypoint>.tex
```

- Without `latexmk`, run the engine, BibTeX or Biber if needed, then rerun the
  engine until references and citations settle.
- Do not treat `latexmk -f` as success. It only continues past errors.
- Do not enable `-shell-escape` unless the project already requires it or the
  user approves it.
