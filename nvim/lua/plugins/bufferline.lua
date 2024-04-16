return {
    "akinsho/bufferline.nvim",
    enabled = false,
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "catppuccin",
    },
    config = function()
        local mocha = require("catppuccin.palettes").get_palette("mocha")

        require("bufferline").setup({
            options = {
                -- separator_style = "slant",
                offsets = {
                    {
                        filetype = "OverseerList",
                        text = "Tasks",
                        separator = true -- use a "true" to enable the default, or set your own character
                    },
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        separator = true
                    }
                },
            },
            highlights = require("catppuccin.groups.integrations.bufferline").get({
                custom = {
                    all = {
                        close_button_selected = {
                            fg = mocha.subtext1
                        },
                        tab_close = {
                            fg = mocha.subtext1
                        },
                    }
                }
            })
        })

        vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { silent = true, desc = "Next buffer" })
        vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { silent = true, desc = "Previous buffer" })
    end
}
