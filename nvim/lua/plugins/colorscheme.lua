return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = true,
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                transparent_background = false,
                flavour = "mocha",
                no_italic = true,
                no_bold = true,
                integrations = {
                    alpha = true,
                    cmp = true,
                    flash = true,
                    dap = true,
                    dap_ui = true,
                    fidget = true,
                    gitsigns = true,
                    illuminate = true,
                    lsp_trouble = true,
                    markdown = true,
                    mason = true,
                    -- noice = true,
                    native_lsp = { enabled = true },
                    neotree = true,
                    -- telescope = true,
                    semantic_tokens = true,
                    -- ts_rainbow = false,
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

    },
    {
        "vague2k/vague.nvim",
        name = "vague",
        enabled = false,
        priority = 1000,
        config = function()
            require("vague").setup({
                style = {
                    -- "none" is the same thing as default. But "italic" and "bold" are also valid options
                    boolean = "none",
                    number = "none",
                    float = "none",
                    error = "none",
                    comments = "italic",
                    conditionals = "none",
                    functions = "none",
                    headings = "bold",
                    operators = "none",
                    strings = "none",
                    variables = "none",

                    -- keywords
                    keywords = "none",
                    keyword_return = "none",
                    keywords_loop = "none",
                    keywords_label = "none",
                    keywords_exception = "none",

                    -- builtin
                    builtin_constants = "none",
                    builtin_functions = "none",
                    builtin_types = "none",
                    builtin_variables = "none",
                },
            })
        end
    },
}
