return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    always_show = {
                        ".gitignore",
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
            }
        })

        vim.keymap.set("n", "<leader>ft", "<cmd>Neotree toggle<CR>", { silent = true, desc = "Neotree toggle" });
    end
}
