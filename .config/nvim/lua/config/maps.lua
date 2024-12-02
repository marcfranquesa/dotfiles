local map_group = vim.api.nvim_create_augroup("MapGroup", { clear = true })

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "-", "<cmd>Explore<cr>") -- netrw
map("n", "U", "<C-r>") -- redo

map("n", "`", "<Nop>") -- ignore `, only jump to markers with '
map("n", "<Esc>", "<cmd>nohlsearch<cr>") -- clear highlights

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("n", "<C-d>", "<C-d>zz") -- center when jumping around
map("n", "<C-u>", "<C-u>zz") -- center when jumping around

map("n", "<leader>c", ":w! | :AsyncRun compile '<c-r>=expand(\"%:~:.\")<cr>'<cr>") -- compile/run
map("n", "<leader>o", ":!open-compiled <c-r>%<cr><cr>") -- open compiled

-- spell check
map("n", "<leader>se", ":setlocal spell spelllang=en_us<cr>") -- english
map("n", "<leader>ss", ":setlocal spell spelllang=es<cr>") -- spanish
map("n", "<leader>sc", ":setlocal spell spelllang=ca<cr>") -- catalan
map("n", "<leader>sn", ":setlocal nospell<cr>") -- toggle off

-- lsp maps
vim.api.nvim_create_autocmd("LspAttach", {
    group = map_group,
    callback = function()
        map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
        -- map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    end,
})
