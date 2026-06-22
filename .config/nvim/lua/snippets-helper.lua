local present, ls = pcall(require, "luasnip")
if not present then
    return
end

local M = {}

local sn = ls.snippet_node
local i = ls.insert_node

function M.get_ISO_8601_date()
    return os.date("%Y-%m-%d")
end

function M.get_visual(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

function M.clipboard_content()
    local clip = vim.fn.getreg("+")
    return clip ~= "" and clip or "link"
end

return M
