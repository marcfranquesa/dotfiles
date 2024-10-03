return {
  "bamonroe/rnoweb-nvim",
  event = "VeryLazy",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local present, rnoweb = pcall(require, "rnoweb-nvim")
    if present then
      rnoweb.setup()
    end
  end,
}
