return {
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { noremap = true, desc = "LazyGit" })
        end
    },
}
