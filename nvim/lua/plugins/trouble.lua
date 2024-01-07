return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle() end,
            { noremap = true, silent = true, desc = "Trouble toggle" })
        vim.keymap.set("n", "<leader>tn", function() require("trouble").next({ skip_groups = true, jump = true }) end,
            { noremap = true, silent = true, desc = "Trouble next" })
        vim.keymap.set("n", "<leader>tp", function() require("trouble").previous({ skip_groups = true, jump = true }) end,
            { noremap = true, silent = true, desc = "Trouble previous" })
    end
}
