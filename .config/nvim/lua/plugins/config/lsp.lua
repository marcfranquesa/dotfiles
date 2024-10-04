local present1, lspconfig = pcall(require, "lspconfig")
local present2, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not (present1 or present2) then
  return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.bashls.setup({
  capabilities = capabilities,
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
})

lspconfig.pyright.setup({
  capabilities = capabilities,
})

lspconfig.texlab.setup({
  capabilities = capabilities,
})
