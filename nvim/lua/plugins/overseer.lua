return {
    "stevearc/overseer.nvim",
    config = function()
        require("overseer").setup({})

        vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>", { silent = true, desc = "Overseer Run" })
        vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle! bottom<cr>", { silent = true, desc = "Overseer Toggle" })
    end
}
