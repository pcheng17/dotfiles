return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup({
            options = {
                always_divide_middle = true,
                icons_enabled = true,
                component_separators = { left = "|", right = "|" },
                section_separators = "",
            },
            sections = {
                lualine_a = {"mode"},
                lualine_b = {"branch", "diff", "diagnostics"},
                lualine_c = {"filename"},
                lualine_x = {"filetype", "encoding", "fileformat"},
                lualine_y = {},
                lualine_z = {"location"}
            }
        })
    end
}
