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

-- map("n", ";", ":", { silent = false }) -- semicolon to enter command mode
map("n", "-", "<cmd>Ex<CR>") -- netrw
map("n", "U", "<C-r>") -- redo

map("n", "`", "<Nop>") -- ignore `, only jump to markers with '
map("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear highlights

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("n", "<C-d>", "<C-d>zz") -- center when jumping around
map("n", "<C-u>", "<C-u>zz") -- center when jumping around

map("n", "<leader>j", "<cmd>bnext<cr>") -- move to right buffer
map("n", "<leader>k", "<cmd>bprevious<cr>") -- move to left buffer

map("n", "<leader>c", ":w! | :AsyncRun compile '<c-r>=expand(\"%:~:.\")<CR>'<CR>") -- compile/run
map("n", "<leader>o", ":!open-compiled <c-r>%<CR><CR>") -- open compiled

map("n", "<leader>s", "<cmd>setlocal spell! spelllang=en_us<CR>") -- toggle spellcheck

-- lsp maps
vim.api.nvim_create_autocmd("LspAttach", {
    group = map_group,
    callback = function()
        map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
        map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    end,
})
