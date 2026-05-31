# Slide Creation Guidelines

## Frame Structure

Use `\frame{}` or `\begin{frame}...\end{frame}` syntax:

```latex
\frame{
    \frametitle{Title Here}
    % content
}
% or
\begin{frame}
    \frametitle{Title Here}
    % content
\end{frame}
```

### Title Capitalization

Use **sentence case** for frame titles - capitalize only the first word:

```latex
\frametitle{Motivation: Why quantization?}     % correct
\frametitle{KV-cache autoregressive inference} % correct
\frametitle{Motivation: Why Quantization?}     % incorrect
```

Exception: Proper nouns, acronyms, and technical terms retain their standard capitalization.

## Column Layouts

Always use `[T, onlytextwidth]` for top alignment:

```latex
\begin{columns}[T, onlytextwidth]
    \begin{column}{0.15\textwidth}
        \textbf{Label:}
    \end{column}
    \begin{column}{0.85\textwidth}
        Content here
    \end{column}
\end{columns}
```

### Common Column Splits

| Split | Use Case |
|-------|----------|
| `0.15/0.85` | Label + content |
| `0.5/0.5` | Two equal sections |
| `0.48/0.04/0.48` | Two equal sections with gap |
| `0.6/0.4` or `0.4/0.6` | Content + figure |

Note: Choose the column split that fits the content. Label-columns suit Q&A or labeled sections; equal splits suit comparisons; 0.6/0.4 suits text + figure.

### Labels for 0.15/0.85 Layout

When using a label-column layout, pick a label that fits the content:

- `\textbf{Question:}`, `\textbf{Problem:}`, `\textbf{Observation:}`
- `\textbf{Solution:}`, `\textbf{Remarks:}`, `\textbf{Trade-off:}`
- `\textbf{In practice:}`, `\textbf{Parameters:}`

Choose the layout that matches the content structure. Not every slide needs label-columns.

## Text Formatting

### Bullet Points

Use `$\circ$` for main points (NOT `\item` in regular text):

```latex
$\circ$ First point \\[2mm]
$\circ$ Second point \\[2mm]
$\circ$ Third point
```

For nested lists use `\begin{itemize}`:

```latex
\begin{itemize}
    \item Sub-point one
    \item Sub-point two
\end{itemize}
```

### Emphasis

| Command | Effect | Use Case |
|---------|--------|----------|
| `\textbf{text}` | **Bold** | Key terms, labels |
| `\emph{text}` | *Italics* | Emphasis |
| `\red{text}` | Red text | Important highlights |
| `\blue{text}` | Blue text | Secondary highlights |
| `\green{text}` | Green text | Positive/success |
| `\magenta{text}` | Magenta text | Alternative emphasis |

### Spacing

| Command | Description |
|---------|-------------|
| `\\[2mm]` | Line break with 2mm space (between bullets) |
| `\\[5mm]` | Larger line break |
| `\medskip` | Medium vertical space |
| `\smallskip` | Small vertical space |
| `\vspace{3mm}` | Explicit vertical space |
| `\hfill` | Push content to right (for inline comments) |

## Math Notation

### General Math Commands

Common math commands that may be available (check your preamble):
- `\R` - real numbers ($\mathbb{R}$)
- `\norm{x}` - norm ($\|x\|$)
- `\set{x}` - set braces
- `\abs{x}` - absolute value
- `\argmax`, `\argmin` - arg max/min operators
- `\probab{x}`, `\expect{x}`, `\var{x}` - probability/expectation/variance
- `\tr{x}` - trace
- `\diag`, `\conv`, `\supp`, `\prox` - common operators

### Inline vs Display

```latex
$\text{p}(w_t|w_{1:t-1})$           % inline
$$y = f(x)$$                        % display centered
```

### Aligned Equations

```latex
\begin{align*}
    y_1 &= f(x_1), \\
    y_2 &= f(x_2).
\end{align*}
```

### Transpose and Cases

```latex
(\cdot)^\intercal              % transpose
(\cdot)^\top                   % alternative transpose

M_{ij} = \begin{cases}
    1, & i \geq j,  \\
    0, & i < j
\end{cases}
```

## Colors

### Common Color Commands

| Command | Use Case |
|---------|----------|
| `\red{}` or `\mred{}` | Important highlights |
| `\blue{}` or `\mblue{}` | Secondary highlights |
| `\green{}` | Success/positive |
| `\magenta{}` or `\mmagenta{}` | Alternative emphasis |

### Usage in Text

```latex
\red{important text}           % red highlight
\mred{1.}                      % red numbering in algorithms
{\color{red} text}             % alternative syntax
\textcolor{orange}{text}       % named colors
```

Note: Check `layout.md` for the specific colors defined in your presentation's preamble.

## Content Blocks

```latex
\begin{definition}[Name]
    Mathematical definition here
\end{definition}

\begin{block}{Title}
    General content block
\end{block}

\begin{alertblock}{Title}
    Important/warning content
\end{alertblock}

\begin{example}
    Example content
\end{example}
```

## Tables

### Simple Table

```latex
\begin{center}
\begin{tabular}{l c c c}
    & \textbf{Column 1} & \textbf{Column 2} & \textbf{Column 3} \\
    \hline
    Row 1 & value & value & value \\
    Row 2 & value & value & value \\
\end{tabular}
\end{center}
```

### Algorithm Box

```latex
\begin{table}[!ht]
    \begin{center}
        \begin{tabular}{|p{6.5cm}|}
            \hline
            \multicolumn{1}{|c|}{\bf Algorithm Name} \\ \hline
            \textbf{\mred{1.}}~First step \\
            \textbf{\mred{2.}}~\textbf{For} $t=1, \ldots, T$
            \begin{itemize}
                \item Compute something
                \item Next computation \hfill \red{comment}
            \end{itemize} \\
            \textbf{\mred{3.}}~Output: result \\
            \hline
        \end{tabular}
    \end{center}
\end{table}
```

## Figures

### Standard Figure

```latex
\begin{figure}[H]
    \includegraphics[width=0.7\textwidth]{./figures/filename}
    \caption{Caption text~\cite{reference}.}
\end{figure}
```

### Centered Figure (No Caption)

```latex
\begin{figure}
    \centering
    \includegraphics[scale=0.2]{figures/filename.pdf}
\end{figure}
```

## TikZ Diagrams

### Common Style Definitions

```latex
\begin{tikzpicture}[
    x=1.0cm, y=0.65cm,
    box/.style={rounded corners=3pt, minimum width=1.1cm, minimum height=0.5cm, draw, font=\small, inner sep=2pt},
    arr/.style={->, thick, gray!70, >=stealth}
]
```

### Color Usage in TikZ

```latex
fill=blue!30               % light blue
fill=green!50              % medium green
fill=gray!30               % light gray
draw=black                 % black border
```

## Citations

```latex
~\cite{author2024paper}    % single citation
~\cite{paper1, paper2}     % multiple citations
```

Note: Use `~` before `\cite` to prevent line break before citation.

## Progressive Reveals (Overlays)

```latex
\begin{overlayarea}{\textwidth}{7cm}
    \only<1>{Content for slide 1}
    \only<2>{Content for slide 2}
    \only<3-4>{Content for slides 3 and 4}
\end{overlayarea}

\onslide<2->{Appears from slide 2 onwards}
```

## Writing Style

**Write for the ear.** Slides are spoken aloud. Use short, direct sentences: subject, verb, object. If a bullet needs a dash to connect two ideas, it is saying two things. Split it.

**Forbidden: `--` and `---`** (en-dash and em-dash in LaTeX). Use alternatives instead:

| Bad | Good | Why |
|-----|------|-----|
| `router unstable---before representations form` | `router unstable before representations form` | Remove the dash entirely |
| `two phases---warm-up and fine-tuning` | `two phases: warm-up and fine-tuning` | Use a colon to introduce a list |
| `accuracy improves--but slowly` | `accuracy improves, but slowly` | Use a comma |
| `the model---a 7B variant---converges` | `the model (a 7B variant) converges` | Use parentheses for asides |
| `Steps 0--70K` | `Steps 0 to 70K` | Write "to" for number ranges |

**Bullet philosophy:** Keep bullets under ~15 words. If a bullet feels long, split it or cut qualifiers. Three short bullets beat one comprehensive sentence.

## Forbidden Decorative Patterns

Do NOT use any of the following. They produce inconsistent, ugly slides:

- `mdframed`, `tcolorbox`, `fcolorbox`, or any colored-background box environment
- `backgroundcolor=` on any environment (except TikZ diagram nodes where fill is semantically meaningful)
- `\newlength`, `\setlength` or custom length definitions
- `minipage` nested inside `\begin{column}` environments
- Decorative borders (`linecolor=`, thick colored lines as visual accents)
- Numbered circle badges or card-style TikZ layouts for text content
- `\fbox`, `\colorbox`, `\shadowbox` or any box-drawing commands around text

**For emphasis, use only:** `\textbf{}`, `\red{}`, `\blue{}`, `$\circ$` bullets, and the standard `block`/`definition`/`alertblock` environments from Beamer.

**For quotes or citations in text:** Use italics and `\hfill` attribution, not box environments.

## Quality Standards

### Content Density

- Maximum 3-4 main bullet points per slide
- Each bullet should be 1-2 lines max
- Use multiple slides rather than overcrowding

### Visual Hierarchy

1. Frame title (automatic formatting)
2. Section labels in left column (bold)
3. Main content with `$\circ$` bullets
4. Sub-items with `\itemize`
5. Equations (display mode for important formulas)

### Consistency Checklist

- [ ] Frame titles use sentence case (capitalize first word only)
- [ ] Use `$\circ$` bullets, not dashes or `\item` for main points
- [ ] Add `\\[2mm]` between bullet points
- [ ] Use `[T, onlytextwidth]` on all column environments
- [ ] Use `\red{}` for key highlights (not underline or other)
- [ ] Place inline comments with `\hfill \red{comment}`
- [ ] Use `~\cite{}` for citations (with tilde)
- [ ] No `--` or `---` anywhere in text (use commas, semicolons, or parentheses)

## Typical Slide Patterns

### Side-by-Side: Content + Figure

```latex
\begin{columns}[onlytextwidth]
    \begin{column}{0.6\textwidth}
        \begin{definition}[Name]
            Mathematical definition here
        \end{definition}
        $\circ$ Explanation point
    \end{column}
    \begin{column}{0.4\textwidth}
        \begin{figure}[H]
            \includegraphics[width=\textwidth]{path}
            \caption{Description}
        \end{figure}
    \end{column}
\end{columns}
```

### Comparison Pattern (Two Columns)

```latex
\begin{columns}[T, onlytextwidth]
    \begin{column}{0.48\textwidth}
        \textbf{Option A} \\[2mm]
        \begin{itemize}
            \item Property one
            \item Property two
        \end{itemize}
    \end{column}
    \begin{column}{0.04\textwidth}
    \end{column}
    \begin{column}{0.48\textwidth}
        \textbf{Option B} \\[2mm]
        \begin{itemize}
            \item Property one
            \item Property two
        \end{itemize}
    \end{column}
\end{columns}
```

### Question-Remarks Pattern

```latex
\frame{
    \frametitle{Topic Name}

    \begin{columns}[T, onlytextwidth]
        \begin{column}{0.15\textwidth}
            \textbf{Question:}
        \end{column}
        \begin{column}{0.85\textwidth}
            $\circ$ Main question or observation
        \end{column}
    \end{columns}
    \medskip

    \begin{columns}[T, onlytextwidth]
        \begin{column}{0.15\textwidth}
            \textbf{Remarks:}
        \end{column}
        \begin{column}{0.85\textwidth}
            $\circ$ First remark \\[2mm]
            $\circ$ Second remark with math $x = y$ \\[2mm]
            $\circ$ Third remark
        \end{column}
    \end{columns}
}
```
