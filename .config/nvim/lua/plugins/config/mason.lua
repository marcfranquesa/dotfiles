local present1, mason = pcall(require, "mason")
if not present1 then
    return
end

mason.setup()

local mason_ensure_installed = {
    -- formatters
    "ruff", -- python
    "shfmt", -- shell
    "stylua", -- lua
    "tex-fmt", -- tex
    -- linters
    "selene", -- lua
    -- lsp
    "bash-language-server",
    "gopls",
    "lua-language-server",
    "pyright",
    "rust-analyzer",
    "texlab",
    "typescript-language-server",
}
vim.api.nvim_create_user_command("MasonInstallAll", function()
    local packages = table.concat(mason_ensure_installed, " ")
    vim.cmd("MasonInstall " .. packages)
end, {})
