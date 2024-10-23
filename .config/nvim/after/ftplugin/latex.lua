local function synctex_jump()
    local line = vim.fn.line(".")
    local column = vim.fn.col(".")
    local file = vim.fn.expand("%")
    local location = line .. ":" .. column .. ":" .. file .. " main.pdf"

    vim.cmd(":silent !zathura --synctex-forward " .. location)
end

vim.api.nvim_create_user_command("SynctexJump", synctex_jump, {})

vim.api.nvim_set_keymap("n", "<cr>", ":SynctexJump<cr>", { noremap = true, silent = true })
