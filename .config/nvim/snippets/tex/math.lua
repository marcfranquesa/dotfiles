local helpers = require("snippets-helper")
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local ts_helpers = require("snippets-ts")
local in_text = ts_helpers.in_text
local in_math = ts_helpers.in_math

return {
    s({ trig = "mm", snippetType = "autosnippet" }, fmta([[$ <> $]], { i(1) })),
    s(
        { trig = "\\[", snippetType = "autosnippet" },
        fmta(
            [[
                \[
                    <>
                \]
            ]],
            { i(1) }
        ),
        { condition = in_text }
    ),
    -- lim
    s(
        { trig = "lim", snippetType = "autosnippet" },
        fmta([[\lim_{<>}]], {
            i(1, "x \\to \\infty"),
        }),
        { condition = in_math }
    ),
    s(
        { trig = "sum", snippetType = "autosnippet" },
        fmta([[\sum_{<>}^{<>}]], {
            i(1, "n = 1"),
            i(2, "\\infty"),
        }),
        { condition = in_math }
    ),
    s(
        { trig = "prod", snippetType = "autosnippet" },
        fmta([[\prod_{<>}^{<>}]], {
            i(1, "n = 1"),
            i(2, "\\infty"),
        }),
        { condition = in_math }
    ),
    s(
        { trig = "//", snippetType = "autosnippet" },
        fmta([[\frac{<>}{<>}]], {
            i(1),
            i(2),
        }),
        { condition = in_math }
    ),
    s({ trig = "->", snippetType = "autosnippet" }, { t("\\rightarrow") }, { condition = in_math }),
    s({ trig = "<-", snippetType = "autosnippet" }, { t("\\leftarrow") }, { condition = in_math }),
}
