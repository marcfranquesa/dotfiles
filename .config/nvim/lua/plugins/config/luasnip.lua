local present, luasnip = pcall(require, "luasnip")
if present then
    luasnip.setup({
        enable_autosnippets = true,
    })

    local config_dir = os.getenv("XDG_CONFIG_HOME") or "~/.config"
    require("luasnip.loaders.from_lua").lazy_load({ paths = config_dir .. "/nvim/snippets" })
end
