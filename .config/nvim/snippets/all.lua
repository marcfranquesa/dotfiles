local helpers = require("snippets-helper")
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    s(
        { trig = "!name", snippetType = "autosnippet" },
        t({ "Marc Franquesa Monés" })
    ),
}
