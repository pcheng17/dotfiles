return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                flavour = "mocha",
                no_italic = true,
            })
        end,
    },
    {
        "rose-pine/neovim",
        enabled = false,
        name = "rose-pine",
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                variant = "main",
                styles = {
                    bold = false,
                    italic = false,
                },
                highlight_groups = {
                    Comment = { fg = "muted" }
                }
            })
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        enabled = false,
        name = "nightfox",
        priority = 1000,
        config = function()
            require("nightfox").setup({
                -- options = {
                --     styles = {
                --         comments = "italic",
                --     }
                -- }
            })
        end
    },
    {
        "folke/tokyonight.nvim",
        enabled = false,
        name = "tokyonight",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
            })
        end

    }

}
