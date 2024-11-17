local helpers = require("snippets-helper")
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    -- online resources
    s(
        { trig = "url", snippetType = "autosnippet" },
        fmta(
            [[
                @misc{<>,
                  author       = {<>},
                  title        = {<>},
                  howpublished = {\url{<>}},
                  note         = {Accessed: <>},
                  year         = {<>}
                }
            ]],
            {
                i(1, "key"),
                i(2, "Author"),
                i(3, "Title"),
                i(4, "Link"),
                i(5, helpers.get_ISO_8601_date()),
                i(6, "Year published"),
            }
        ),
        { condition = line_begin }
    ),
}
