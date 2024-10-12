local config_home = os.getenv("XDG_CONFIG_HOME") or "~/.config"

-- latex
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    pattern = "*.tex",
    callback = function()
        vim.cmd("0r " .. config_home .. "/nvim/skeletons/latex.skeleton")
        vim.cmd("29")
    end,
})

-- python
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    pattern = "*.py",
    callback = function()
        vim.cmd("0r " .. config_home .. "/nvim/skeletons/python.skeleton")
        vim.cmd("call cursor(5, 5)")
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    pattern = "pyproject.toml",
    callback = function()
        vim.cmd("0r " .. config_home .. "/nvim/skeletons/pyproject.skeleton")
        vim.cmd("0")
    end,
})
