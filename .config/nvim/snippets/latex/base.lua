local helpers = require("snippets-helper")
local get_visual = helpers.get_visual
local clipboard_content = helpers.clipboard_content
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    s({ trig = "{", snippetType = "autosnippet" }, fmta("{<>}", { i(1) })),
    -- section
    s({ trig = "ss", snippetType = "autosnippet" }, fmta("\\section{<>}", { i(1) }), { condition = line_begin }),
    -- subsection
    s({ trig = "bs", snippetType = "autosnippet" }, fmta("\\subsection{<>}", { i(1) }), { condition = line_begin }),
    -- subsubsection
    s({ trig = "bbs", snippetType = "autosnippet" }, fmta("\\subsubsection{<>}", { i(1) }), { condition = line_begin }),
    -- new item
    s({ trig = "ii", snippetType = "autosnippet" }, { t("\\item ") }, { condition = line_begin }),
    -- link
    s(
        { trig = "href", snippetType = "autosnippet" },
        fmta([[\href{<>}{<>}]], {
            f(clipboard_content, {}),
            d(1, get_visual),
        })
    ),
    -- reference
    s({ trig = "ref", snippetType = "autosnippet" }, fmta("\\ref{<>}", { i(1) })),
    -- cite
    s({ trig = "cite", snippetType = "autosnippet" }, fmta("\\cite{<>}", { i(1) })),
}
