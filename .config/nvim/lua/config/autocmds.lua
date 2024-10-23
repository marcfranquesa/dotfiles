-- highlight on yank
vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

-- set latex filetype
vim.api.nvim_create_augroup("LatexFiletype", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = "LatexFiletype",
    pattern = "*.tex",
    callback = function()
        vim.bo.filetype = "latex"
        vim.wo.spell = true
    end,
})

