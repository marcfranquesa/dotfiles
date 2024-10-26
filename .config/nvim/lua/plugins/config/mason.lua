local present1, mason = pcall(require, "mason")
if not present1 then
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
    -- lsp
    "bashls",
    "gopls",
    "lua_ls",
    "pyright",
    "rust-lang",
    "texlab",
    "rust-analyzer",
}
vim.api.nvim_create_user_command("MasonInstallAll", function()
    local packages = table.concat(mason_ensure_installed, " ")
    vim.cmd("MasonInstall " .. packages)
end, {})
