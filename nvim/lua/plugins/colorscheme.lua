return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = true,
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
        name = "rose-pine",
        enabled = false,
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
        name = "nightfox",
        enabled = false,
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
        name = "tokyonight",
        enabled = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
            })
        end

    }

}
