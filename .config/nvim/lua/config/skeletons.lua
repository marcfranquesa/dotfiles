local skeletons_group = vim.api.nvim_create_augroup("SkeletonsGroup", { clear = true })

local config_dir = os.getenv("XDG_CONFIG_HOME") or "~/.config"
local skeletons_dir = config_dir .. "/nvim/skeletons"

-- latex
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    group = skeletons_group,
    pattern = "*.tex",
    callback = function()
        vim.cmd("0r " .. skeletons_dir .. "/latex.skeleton")
        vim.cmd("29")
    end,
})

-- python
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    group = skeletons_group,
    pattern = "*.py",
    callback = function()
        vim.cmd("0r " .. skeletons_dir .. "/python.skeleton")
        vim.cmd("call cursor(5, 5)")
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    group = skeletons_group,
    pattern = "pyproject.toml",
    callback = function()
        vim.cmd("0r " .. skeletons_dir .. "/pyproject.skeleton")
        vim.cmd("0")
    end,
})
