return {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
        "<leader>fe",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        local icons = require("icons")
        require("neo-tree").setup({
            close_if_last_window = true,
            default_component_configs = {
                diagnostics = {
                    symbols = {
                        hint = icons.diagnostics.Hint,
                        info = icons.diagnostics.Info,
                        warn = icons.diagnostics.Warn,
                        error = icons.diagnostics.Error,
                    },
                    highlights = {
                        hint = "DiagnosticSignHint",
                        info = "DiagnosticSignInfo",
                        warn = "DiagnosticSignWarn",
                        error = "DiagnosticSignError",
                    },
                },
            },
            filesystem = {
                filtered_items = {
                    always_show = {
                        ".gitignore",
                        ".github",
                        ".vscode",
                        "LocalFlags.h", -- work
                        ".clang-format",
                    },
                    never_show = {
                        ".git",
                        ".DS_Store",
                        "lazy-lock.json"
                    },
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                }
            },
        })

        vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle<CR>", { silent = true, desc = "Neotree toggle" });
    end
}
