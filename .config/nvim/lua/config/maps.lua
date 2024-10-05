local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", ";", ":", { silent = false }) -- semicolon to enter command mode

map("n", "<C-d>", "<C-d>zz") -- center when jumping around
map("n", "<C-u>", "<C-u>zz") -- center when jumping around

map("n", "<leader>j", "<cmd>bnext<cr>") -- move to right buffer
map("n", "<leader>k", "<cmd>bprevious<cr>") -- move to left buffer

map("n", "<leader>c", ":w! | :AsyncRun compile '<c-r>%'<CR>") -- compile documents
map("n", "<leader>o", ":!open-compiled <c-r>%<CR><CR>") -- open compiled documents

map("n", "<leader>s", "<cmd>setlocal spell! spelllang=en_us<CR>") -- toggle spellcheck
