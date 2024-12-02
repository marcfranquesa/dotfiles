return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {
            "bash",
            "bibtex",
            "diff",
            "go",
            "gomod",
            "gowork",
            "gosum",
            "html",
            "javascript",
            "latex",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "rust",
            "toml",
            "typescript",
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
