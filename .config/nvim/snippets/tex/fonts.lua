local helpers = require("snippets-helper")
local ts_helpers = require("snippets-ts")
local in_text = ts_helpers.in_text
local in_math = ts_helpers.in_math

return {
    -- small caps / versalita
    s({ trig = "vv", snippetType = "autosnippet", condition = in_text }, fmta([[\textsc{<>}]], { i(1) })),
    -- italics
    s({ trig = "ii", snippetType = "autosnippet", condition = in_text }, fmta([[\textit{<>}]], { i(1) })),
    -- bold
    s({ trig = "bb", snippetType = "autosnippet", condition = in_text }, fmta([[\textbf{<>}]], { i(1) })),
    -- underline
    s({ trig = "uu", snippetType = "autosnippet", condition = in_text }, fmta([[\ul{<>}]], { i(1) })),

    -- mathcal
    s({ trig = "cal", snippetType = "autosnippet", condition = in_math }, fmta([[\mathcal{<>}]], { i(1) })),
    -- mathbf
    s({ trig = "bb", snippetType = "autosnippet", condition = in_math }, fmta([[\mathbf{<>}]], { i(1) })),
    -- mathbb
    s({ trig = "zz", snippetType = "autosnippet", condition = in_math }, fmta([[\mathbb{<>}]], { i(1) })),
    s({ trig = "zz", snippetType = "autosnippet", condition = in_text }, fmta([[$ \mathbb{<>} $]], { i(1) })),
}
