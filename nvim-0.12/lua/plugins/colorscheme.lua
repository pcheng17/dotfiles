return {
    "catppuccin/nvim",
    enabled = true,
    name = "catppuccin",
    config = function()
        require('catppuccin').setup({
            transparent_background = false,
            flavour = "mocha",
            no_italic = true,
            no_bold = true,
            styles = {
                comments = { "italic" },
                conditionals = {},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
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
    end
}
