vim.wo.spell = true

local function synctex_jump()
    local line = vim.fn.line(".")
    local column = vim.fn.col(".")
    local file = vim.fn.expand("%")
    local cmd = ":silent !open-compiled " .. file .. " " .. line .. " " .. column
    vim.cmd(cmd)
end

vim.api.nvim_create_user_command("SynctexJump", synctex_jump, {})

vim.api.nvim_set_keymap("n", "<cr>", ":SynctexJump<cr>", { noremap = true, silent = true })
