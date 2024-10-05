local present, luasnip = pcall(require, "luasnip")
if present then
    luasnip.setup({
        enable_autosnippets = true,
    })
    -- require('luasnip.loaders.from_lua').lazy_load({ paths = '~/.config/nvim/snippets' })
end
