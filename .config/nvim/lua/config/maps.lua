local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("i", "jj", "<Esc>")

map("n", "<leader>3", ":w! | :AsyncRun vim_compile '<c-r>%'<CR>") -- compile documents
map("n", "<leader>4", ":!vim_output <c-r>%<CR><CR>") -- open compiled documents
