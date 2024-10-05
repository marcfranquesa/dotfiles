return {
    "skywind3000/asyncrun.vim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.g.asyncrun_open = 3
        vim.g.asyncrun_rootmarks = { ".svn", ".git", ".root", "_darcs" }
    end,
}
