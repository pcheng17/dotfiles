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
                integrations = {
                    alpha = true,
                    cmp = true,
                    flash = true,
                    fidget = true,
                    gitsigns = true,
                    harpoon = true,
                    illuminate = true,
                    lsp_trouble = true,
                    mason = true,
                    -- noice = true,
                    native_lsp = { enabled = true },
                    neotree = true,
                    overseer = true,
                    telescope = true,
                    treesitter = true,
                    treesitter_context = true,
                    which_key = true,
                }
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
