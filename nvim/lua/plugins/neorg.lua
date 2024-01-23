return {
    "nvim-neorg/neorg",
    enabled = false,
    cmd = { "Neorg" },
    keys = {
        "<leader>ni",
    },
    build = ":Neorg sync-parsers",
    -- tag = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
                    },
                },
            },
        }

        vim.keymap.set("n", "<leader>ni", ":Neorg index<cr>", { silent = true, desc = "Default Neorg index" })
    end,
}
