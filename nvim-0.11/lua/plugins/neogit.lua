return {
    "NeogitOrg/neogit",
    keys = {
        { "<leader>ng", "<cmd>Neogit<cr>", mode = "n", desc = "Neogit", silent = true },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "sindrets/diffview.nvim",        -- optional - Diff integration
        "ibhagwan/fzf-lua",              -- optional
    },
    config = true
}
