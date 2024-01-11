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
        config = function()
            require("nightfox").setup({
                options = {
                    styles = {
                        comments = "italic",
                    }
                }
            })
        end
    }
}
