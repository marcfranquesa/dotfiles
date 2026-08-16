return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = { theme = "auto", component_separators = "", section_separators = "" },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { { "branch", icons_enabled = false }, "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "diff", "filetype" },
            lualine_y = {},
            lualine_z = { "progress" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
    },
}
