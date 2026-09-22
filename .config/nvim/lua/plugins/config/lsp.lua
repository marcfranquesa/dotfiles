local present1, lspconfig = pcall(require, "lspconfig")
local present2, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not (present1 and present2) then
    return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

for _, server in ipairs({ "bashls", "gopls", "pyright", "tinymist", "rust_analyzer", "ts_ls" }) do
    lspconfig[server].setup({ capabilities = capabilities })
end

lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

lspconfig.texlab.setup({
    filetypes = { "tex", "plaintex", "bib", "latex" },
    capabilities = capabilities,
})
