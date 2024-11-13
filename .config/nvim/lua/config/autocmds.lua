-- highlight on yank
vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

vim.api.nvim_create_augroup("MarkdownTitle", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
    group = "MarkdownTitle",
    pattern = "*.md",
    callback = function()
        local filename = vim.fn.expand("%:t:r")
        vim.api.nvim_buf_set_lines(0, 0, 0, false, { "# " .. filename })
    end,
})
