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
                }
            }
        })

        vim.keymap.set("n", "<C-b>", "<cmd>Neotree toggle<CR>", { noremap = true, silent = true });
    end
}
