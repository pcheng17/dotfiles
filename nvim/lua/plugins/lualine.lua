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
                disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { },
                lualine_y = { "filetype", "encoding", "fileformat" },
                lualine_z = {
                    {
                        "location", padding = { left = 1, right = 1 }
                    }
                },
            }
        })
    end
}
