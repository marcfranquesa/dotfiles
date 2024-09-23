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
    highlight = {
      enable = true,
      use_languagetree = true,
      custom_captures = {
        ["punctuation.delimiter"] = "TSInclude",
        ["punctuation.special"] = "TSInclude",
        ["text.math"] = "TSFunction",
        ["text.title"] = "TSParameter",
      },
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
        lua = "-- %s",
      },
    },
  },
}
