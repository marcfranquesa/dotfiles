local helpers = require("snippets-helper")
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    -- generic
    s(
        { trig = "beg", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{<>}
                    <>
                \end{<>}
            ]],
            {
                i(1),
                i(2),
                rep(1),
            }
        ),
        { condition = line_begin }
    ),
    -- figure
    s(
        { trig = "fig", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{figure}[h!]
                    \centering
                    <>
                    \caption{<>}
                    \label{fig:<>}
                \end{figure}
            ]],
            {
                i(1),
                i(2),
                i(3),
            }
        ),
        { condition = line_begin }
    ),
    -- split page
    s(
        { trig = "2pg", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{minipage}{.5\textwidth}
                    <>
                \end{minipage}%
                \begin{minipage}{.5\textwidth}
                    <>
                \end{minipage}
            ]],
            {
                i(1),
                i(2),
            }
        ),
        { condition = line_begin }
    ),
    -- image
    s(
        { trig = "img", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{figure}[h!]
                    \centering
                    \includegraphics[width=<>cm]{<>}
                    \caption{<>}
                    \label{fig:<>}
                \end{figure}
            ]],
            {
                i(1, "5"),
                i(2, "file"),
                i(3, "caption"),
                rep(2),
            }
        ),
        { condition = line_begin }
    ),
    -- 2 side by side images
    s(
        { trig = "2img", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{figure}[h!]
                    \centering
                    \begin{minipage}{.5\textwidth}
                        \centering
                        \includegraphics[width=\linewidth]{<>}
                        \caption{<>}
                        \label{fig:<>}
                    \end{minipage}%
                    \begin{minipage}{.5\textwidth}
                        \centering
                        \includegraphics[width=\linewidth]{<>}
                        \caption{<>}
                        \label{fig:<>}
                    \end{minipage}
                \end{figure}
            ]],
            {
                i(1, "file1"),
                i(2, "caption1"),
                rep(1),
                i(3, "file2"),
                i(4, "caption2"),
                rep(3),
            }
        ),
        { condition = line_begin }
    ),
    -- svg
    s(
        { trig = "svg", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{figure}[h!]
                    \centering
                    \includesvg[width=<>cm]{<>}
                    \caption{<>}
                    \label{fig:<>}
                \end{figure}
            ]],
            {
                i(1, "5"),
                i(2, "file"),
                i(3, "caption"),
                rep(2),
            }
        ),
        { condition = line_begin }
    ),
    -- itemize
    s(
        { trig = "item", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{itemize}
                    \item <>
                \end{itemize}
            ]],
            {
                i(1),
            }
        ),
        { condition = line_begin }
    ),
    -- enumerate
    s(
        { trig = "enum", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{enumerate}
                    \item <>
                \end{enumerate}
            ]],
            {
                i(1),
            }
        ),
        { condition = line_begin }
    ),
    -- frame
    s(
        { trig = "frm", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{frame}{<>}
                    <>
                \end{frame}
            ]],
            {
                i(1, "Title"),
                i(2),
            }
        ),
        { condition = line_begin }
    ),
    -- theorem
    s(
        { trig = "thm", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{theorem}[<>]
                    <>
                \end{theorem}
            ]],
            {
                i(1),
                i(2),
            }
        ),
        { condition = line_begin }
    ),
    -- lemma
    s(
        { trig = "lma", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{lemma}{<>}
                    <>
                \end{lemma}
            ]],
            {
                i(1, "Title"),
                i(2),
            }
        ),
        { condition = line_begin }
    ),
    -- proposition
    s(
        { trig = "prp", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{proposition}[<>]
                    <>
                \end{proposition}
            ]],
            {
                i(1),
                i(2),
            }
        ),
        { condition = line_begin }
    ),
    -- proof
    s(
        { trig = "prf", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{proof}
                    <>
                \end{proof}
            ]],
            {
                i(1),
            }
        ),
        { condition = line_begin }
    ),
    -- definition
    s(
        { trig = "dfn", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{definition}[<>]
                    <>
                \end{definition}
            ]],
            {
                i(1),
                i(2),
            }
        ),
        { condition = line_begin }
    ),
    -- remark
    s(
        { trig = "rmk", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{remark}
                    <>
                \end{remark}
            ]],
            {
                i(1),
            }
        ),
        { condition = line_begin }
    ),
}
