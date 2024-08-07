return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons" ,
        "catppuccin",
    },
    config = function()
        local function truncate_branch(branch)
            if not branch or branch == "" then
                return ""
            end

            -- Match the branch name to the specified format
            local _, _, ticket_number = string.find(branch, "[a-z]+/CLI%-(%d+)")

            if ticket_number then
                return "CLI-" .. ticket_number
            else
                return branch
            end
        end

        local icons = require("icons")
        require("lualine").setup({
            options = {
                theme = "catppuccin",
                always_divide_middle = true,
                icons_enabled = true,
                component_separators = { left = "|", right = "|" },
                section_separators = "",
                -- component_separators = { left = '', right = ''},
                -- section_separators = { left = '', right = ''},
                disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
            },
            sections = {
                lualine_a = { "mode", },
                lualine_b = {
                    { "branch", fmt = truncate_branch, icon = icons.misc.git },
                    "diff",
                    { "diagnostics",
                        symbols = {
                            error = icons.diagnostics.Error .. " ",
                            warn = icons.diagnostics.Warn .. " ",
                            info = icons.diagnostics.Info .. " ",
                            hint = icons.diagnostics.Hint .. " ",
                        }
                    },
                },
                lualine_c = {
                    { "filename", path = 1 },
                },
                lualine_x = { },
                lualine_y = {
                    "filetype",
                    "progress",
                    -- "encoding",
                    -- {
                    --     "fileformat",
                    --     icons_enabled = false,
                    -- }
                },
                lualine_z = {
                    {
                        "location", padding = { left = 1, right = 1 }
                    }
                },
            }
        })
    end
}
