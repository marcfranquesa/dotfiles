# Poster Creation Guidelines

Reference for the `poster-creator` agent. Describes Beamer poster patterns, density rules, and style constraints.

## Document Structure

A Beamer poster is a single frame with columns:

```latex
\documentclass[final]{beamer}
\usepackage[size=custom,width=118.9,height=84.1,scale=1.3]{beamerposter}
\usetheme{gemini}
\usecolortheme{gemini}

\begin{document}
\begin{frame}[t]
    \begin{columns}[t]
        \separatorcolumn
        \begin{column}{\colwidth}
            \begin{alertblock}{Summary} ... \end{alertblock}
            \begin{block}{Details}      ... \end{block}
        \end{column}
        \separatorcolumn
        \begin{column}{\colwidth}
            ...
        \end{column}
        \separatorcolumn
        \begin{column}{\colwidth}
            ...
        \end{column}
        \separatorcolumn
    \end{columns}
\end{frame}
\end{document}
```

You add blocks into one of the `\begin{column}{\colwidth}...\end{column}` regions.

## Block Types

| Environment | Purpose |
|---|---|
| `\begin{alertblock}{Title}` | High-emphasis blocks (Summary, Main Theory) |
| `\begin{block}{Title}` | Standard blocks (content, figures, references) |

Pick `alertblock` sparingly — too many highlights defeats the purpose. Typically 1-2 per poster.

## Titles

Sentence case: `Why clique size matters`, not `Why Clique Size Matters`. Exceptions: proper nouns, acronyms (GAS, PC, MEC).

## Body Font Size

Start the body with a size directive:

```latex
\begin{block}{Title}
    \small
    ...
\end{block}
```

- `\small` — default for most blocks
- `\footnotesize` — references, dense tables
- Never `\tiny`

## Content Density (CRITICAL)

Posters are read from 1-2 meters. Dense walls fail.

Per block:
- Max 4-5 bullets in an itemize
- Max 2 paragraphs of prose, ~3-4 lines each
- Max 1 figure OR 1 table OR 1 TikZ per block (not multiple)
- Bullets: 1-2 lines, under ~15 words

Prefer whitespace over completeness.

## Bullets

```latex
\begin{itemize}
    \item First point
    \item Second point
    \item Third point
\end{itemize}
```

Posters use standard `\item` bullets (unlike slides which use `$\circ$`). The theme styles them.

## Emphasis

| Command | Effect |
|---|---|
| `\textbf{...}` | Bold |
| `\emph{...}` | Italic |
| `\alert{...}` | Theme accent color |

Custom theme color macros (e.g., `\red{}`, `\blue{}`) — check `layout.md`.

## Math

Inline: `$x$`. Display: `\[ ... \]`. For aligned equations use `align*`.

Do not use `$$...$$` (plain TeX, discouraged in LaTeX).

## Figures

```latex
\begin{center}
    \includegraphics[width=0.95\linewidth]{figure-name}
\end{center}
```

- Widths always relative to `\linewidth` (inside a column, this equals column width).
- Never hard-code `cm` widths — they will overflow on different paper sizes.
- Side-by-side: `0.48\linewidth` each with `\hfill`.
- Skip captions unless strictly necessary — space is tight.

## Tables

Use booktabs:

```latex
\begin{center}
\begin{tabular}{lcc}
    \toprule
    & Prior work & This work \\
    \midrule
    CI tests & $p^{O(d)}$ & $p^{O(s)}$ \\
    Parameter & degree $d$ & clique $s$ \\
    \bottomrule
\end{tabular}
\end{center}
```

Keep tables narrow. If a table overflows a column, shrink with `\small` or `\footnotesize` on the body, or split into two.

## TikZ

Common patterns used in posters:

```latex
\begin{center}
\begin{tikzpicture}[node distance=0.8cm]
    \node[flowbox] (a) {Step 1};
    \node[flowbox, right=0.8cm of a, fill=green!7] (b) {Step 2};
    \draw[very thick, -{Stealth[length=3mm,width=2mm]}] (a) -- (b);
\end{tikzpicture}
\end{center}
```

Rules:
- Use existing `\tikzset{...}` styles from the preamble when possible.
- Anchors: `(a.east)` not `(a)` for clean arrow endpoints.
- If the diagram is too wide, wrap in `\scalebox{0.9}{...}` or reduce coordinates.
- Do not hard-code colors; prefer theme colors or light fills (`fill=blue!5`).

## In-block Subheadings

If the theme defines `\heading{...}` (check `layout.md`), use it for subsections inside a block:

```latex
\begin{alertblock}{Summary}
    Lead paragraph.

    \heading{At a glance}
    [table or bullets]
\end{alertblock}
```

## References

Small, inline, `\footnotesize`:

```latex
\begin{block}{References}
    \footnotesize
    [1] Spirtes, Glymour, Scheines. \emph{Causation, Prediction, and Search}. MIT Press, 2001.

    [2] Colombo and Maathuis. Order-independent constraint-based causal structure learning. \emph{JMLR}, 2014.
\end{block}
```

Only use BibTeX + `\cite{}` if the poster already has a `.bib` file.

## Writing Style (ZERO TOLERANCE)

**Forbidden: `--` and `---` in non-TikZ, non-comment text.**

| Bad | Good |
|---|---|
| `degree---a quantity that grows` | `degree, a quantity that grows` |
| `two regimes---sparse and dense` | `two regimes: sparse and dense` |
| `Steps 0--70K` | `Steps 0 to 70K` |
| `the algorithm---GAS---runs fast` | `the algorithm (GAS) runs fast` |

The dash-check hook will block any write containing `--`. Use commas, semicolons, colons, parentheses, or write "to" for ranges.

## Forbidden Decorative Patterns

- `mdframed`, `tcolorbox`, `fcolorbox`, `\fbox`, `\colorbox` — the theme already frames blocks.
- `\newlength`, `\setlength` inside a block.
- `\begin{frame}` — the poster is already inside one frame.
- Per-block captions on every figure — only use captions when labels are essential.

## Compilation

Posters typically compile with 2 passes:

```bash
pdflatex -interaction=nonstopmode poster.tex
pdflatex -interaction=nonstopmode poster.tex
```

If a `.bib` file exists, insert a `bibtex poster` between the two passes. Most posters use inline references and do not need this.

## Column Balance Target

Aim for columns that end within ~15% of each other in height. If the user's new block pushes one column well past the others, flag it so the user can rebalance (move a block, cut content, or add content elsewhere).
