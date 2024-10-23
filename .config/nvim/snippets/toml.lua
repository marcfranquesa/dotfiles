local helpers = require("snippets-helper")
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    s(
        { trig = "!pyright", condition = line_begin, snippetType = "autosnippet" },
        t({ "[tool.pyright]", 'venvPath = "."', 'venv = ".venv"', "" })
    ),
}
