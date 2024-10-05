local options = {
    autoindent = true,
    number = true,
    relativenumber = true,
    ignorecase = true, -- case insensitive search
    smartcase = true, -- unless there are capital letters
    cursorline = true,
    scrolloff = 10,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    showmode = false,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- set latex file type
vim.api.nvim_create_augroup("latex_filetype", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = "latex_filetype",
    pattern = "*.tex",
    callback = function()
        vim.bo.filetype = "latex"
        vim.wo.spell = true
    end,
})
