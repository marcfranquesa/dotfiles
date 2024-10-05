return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {
            "bash",
            "bibtex",
            "diff",
            "latex",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "toml",
            "xml",
        },
        indent = { enable = true },
        highlight = { enable = true },
        playground = { enable = true },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
