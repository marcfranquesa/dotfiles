local all_formatters = {
    python = { "ruff format" },
    lua = { "stylua --indent-type Spaces --indent-width 4 --sort-requires" },
    sh = { "shfmt -w -i 4 -ci" },
    tex = { "tex-fmt --tab 4" },
    latex = { "tex-fmt --tab 4" },
    bib = { "tex-fmt --tab 4" },
}

local function format_file()
    local file_path = vim.api.nvim_buf_get_name(0)
    local file_type = vim.bo.filetype

    local formatters = all_formatters[file_type] or {}
    if #formatters == 0 then
        print("No formatter available for " .. file_type .. ".")
        return
    end

    vim.cmd("silent write!")

    for _, formatter in ipairs(formatters) do
        vim.cmd("silent !" .. formatter .. " " .. vim.fn.shellescape(file_path))
    end

    vim.cmd("edit!")
end

vim.api.nvim_create_user_command("FormatFile", format_file, {})

vim.keymap.set("n", "<leader>F", "<cmd>FormatFile<cr>", { silent = true })
