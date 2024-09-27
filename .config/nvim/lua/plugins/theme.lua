return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      styles = {
        bold = false,
        italic = true,
        transparency = false,
      },
    })
    vim.cmd([[colorscheme rose-pine-moon]])
  end,
}
