local parsers = {
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
    "typst",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "rust",
    "toml",
    "typescript",
    "xml",
}

local filetypes = vim.list_extend(vim.deepcopy(parsers), { "sh", "bib", "tex", "plaintex" })

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        vim.treesitter.language.register("bash", "sh")
        vim.treesitter.language.register("bibtex", "bib")
        vim.treesitter.language.register("latex", { "tex", "plaintex" })

        if vim.fn.executable("tree-sitter") == 1 then
            require("nvim-treesitter").install(parsers)
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function()
                if pcall(vim.treesitter.start) then
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
