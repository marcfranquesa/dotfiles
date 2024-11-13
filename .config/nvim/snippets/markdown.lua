local helpers = require("snippets-helper")
local ts_helpers = require("snippets-ts")
local clipboard_content = helpers.clipboard_content
local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- function to dynamically generate markdown table content
local generate_markdown_table = function(args, snip)
    local rows = tonumber(snip.captures[1])
    local cols = tonumber(snip.captures[2])
    local nodes = {}
    -- header
    table.insert(nodes, t("| "))
    for k = 1, cols do
        table.insert(nodes, i(k, " "))
        table.insert(nodes, t(" | "))
    end
    table.insert(nodes, t({ "", "" }))
    -- separator
    table.insert(nodes, t("|"))
    for k = 1, cols do
        table.insert(nodes, t(":---:"))
        table.insert(nodes, t("|"))
    end
    table.insert(nodes, t({ "", "" }))
    -- content
    local ins_indx = cols + 1
    for j = 1, rows - 1 do
        table.insert(nodes, t("| "))
        for k = 1, cols do
            table.insert(nodes, i(ins_indx, " "))
            table.insert(nodes, t(" | "))
            ins_indx = ins_indx + 1
        end
        table.insert(nodes, t({ "", "" }))
    end
    return sn(nil, nodes)
end

return {
    -- new title
    s(
        { trig = "h1", snippetType = "autosnippet" },
        fmta("# <>", {
            i(1),
        })
    ),
    -- new subtitle
    s(
        { trig = "h2", snippetType = "autosnippet" },
        fmta("## <>", {
            i(1),
        })
    ),
    -- new section
    s(
        { trig = "h3", snippetType = "autosnippet" },
        fmta("### <>", {
            i(1),
        })
    ),
    -- new subsection
    s(
        { trig = "h4", snippetType = "autosnippet" },
        fmta("#### <>", {
            i(1),
        })
    ),
    -- URL
    s(
        { trig = "LL", snippetType = "autosnippet" },
        fmta([[[<>](<>)]], {
            f(clipboard_content, {}),
            i(1),
        })
    ),
    -- bold
    s(
        { trig = "bb", snippetType = "autosnippet" },
        fmta("**<>**", {
            i(1),
        })
    ),
    -- italics
    s(
        { trig = "ii", snippetType = "autosnippet" },
        fmta("*<>*", {
            i(1),
        })
    ),
    -- underline
    s(
        { trig = "uu", snippetType = "autosnippet" },
        fmt([[<u>{}</u>]], {
            i(1),
        })
    ),
    -- highlight
    s(
        { trig = "hh", snippetType = "autosnippet" },
        fmta("==<>==", {
            i(1),
        })
    ),
    -- table
    s(
        { trig = "tbl(%d+)x(%d+)", regTrig = true, snippetType = "autosnippet" },
        d(1, generate_markdown_table),
        { condition = line_begin }
    ),
    -- code block
    s(
        { trig = "cc", snippetType = "autosnippet" },
        fmta(
            [[
                ```<>
                <>
                ```
            ]],
            {
                i(1),
                i(2),
            }
        ),
        { condition = line_begin }
    ),
}
