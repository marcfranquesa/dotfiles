local method = ":silent !"

local python_formatters = { "black", "isort" }
local lua_formatters = { "stylua --indent-type Spaces --indent-width 4 --sort-requires" }
local shell_formatters = { "shfmt" }
local tex_formatters = { "tex-fmt --tab 4" }

local function format_file()
    local file_path = vim.api.nvim_buf_get_name(0)
    local file_type = vim.bo.filetype

    local formatters = {}
    if file_type == "lua" then
        formatters = lua_formatters
    elseif file_type == "python" then
        formatters = python_formatters
    elseif file_type == "sh" then
        formatters = shell_formatters
    elseif file_type == "tex" then
        formatters = tex_formatters
    end

    vim.cmd("silent write!")

    if #formatters == 0 then
        print("No formatter available for " .. file_type .. ".")
    end

    for _, formatter in ipairs(formatters) do
        vim.cmd(method .. formatter .. " " .. file_path)
    end

    vim.cmd("edit!")
end

vim.api.nvim_create_user_command("FormatFile", format_file, {})

vim.api.nvim_set_keymap("n", "<leader>F", ":FormatFile<CR>", { noremap = true, silent = true })