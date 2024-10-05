return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("plugins.config.lsp")
    end,
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            config = function()
                require("plugins.config.mason")
            end,
        },
    },
}
