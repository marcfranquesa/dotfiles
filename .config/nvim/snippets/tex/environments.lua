local helpers = require("snippets-helper")
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    -- generic
    s(
        { trig = "\\begin{", snippetType = "autosnippet" },
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
                \begin{figure}[H]
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
    -- svg
    s(
        { trig = "svg", snippetType = "autosnippet" },
        fmta(
            [[
                \begin{figure}[H]
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
        { trig = "frame", snippetType = "autosnippet" },
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
    -- proposition
    s(
        { trig = "prop", snippetType = "autosnippet" },
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
        { trig = "proof", snippetType = "autosnippet" },
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
        { trig = "def", snippetType = "autosnippet" },
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
        { trig = "rem", snippetType = "autosnippet" },
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
