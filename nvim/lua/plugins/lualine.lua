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
                lualine_x = {
                    {
                        "location", padding = { left = 0, right = 1 }
                    }
                },
                lualine_y = { "filetype", "encoding", "fileformat" },
                lualine_z = {
                    function()
                        return os.date(" %I:%M %p")
                    end,
                },
            }
        })
    end
}
