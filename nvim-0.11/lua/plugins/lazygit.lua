return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitFilter",
        "LazyGitCurrentFile",
        "LazyGitFilterCurrentFile",
    },
    keys = { "<leader>lg" },
    dependencies = {
        "nvim-lua/plenary.nvim", -- optional for floating window border deocoration
    },
    config = function()
        vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { noremap = true, desc = "LazyGit" })
    end
}
