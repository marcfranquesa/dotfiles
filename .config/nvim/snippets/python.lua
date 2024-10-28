local helpers = require("snippets-helper")
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    -- function
    s(
        { trig = "fn", snippetType = "autosnippet" },
        fmta(
            [[
                def <>(<>) -<> <>:
                    """ """
                    <>
            ]],
            {
                i(1, "function"),
                i(2, "param = None"),
                t(">"),
                i(3, "None"),
                i(4),
            }
        ),
        { condition = line_begin }
    ),
    -- class
    s(
        { trig = "cls", snippetType = "autosnippet" },
        fmta(
            [[
                class <>(<>):
                    """ """

                    def __init__(self<>) -<> None:
                        <>
            ]],
            {
                i(1, "Class"),
                i(2),
                i(3),
                t(">"),
                i(4),
            }
        ),
        { condition = line_begin }
    ),
}