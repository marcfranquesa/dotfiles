local present1, mason = pcall(require, "mason")
local present2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not (present1 or present2) then
    return
end

mason.setup()

local mason_ensure_installed = {
    -- formatters
    "black", -- python
    "isort", -- python
    "shfmt", -- shell
    "stylua", -- lua
    "tex-fmt", -- tex
    -- linters
    "ruff", -- python
    "selene", -- lua
}
vim.api.nvim_create_user_command("MasonInstallAll", function()
    local packages = table.concat(mason_ensure_installed, " ")
    vim.cmd("MasonInstall " .. packages)
end, {})

mason_lspconfig.setup({
    ensure_installed = {
        "bashls",
        "lua_ls",
        "pyright",
        "texlab",
        "gopls",
    },
    automatic_installation = true,
})
