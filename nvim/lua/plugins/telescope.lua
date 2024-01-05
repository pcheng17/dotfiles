return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({})

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true, desc = "Telescope find files" })
        vim.keymap.set("n", "<leader>fd", builtin.git_files, { noremap = true, silent = true, desc = "Telescope git files" })
        vim.keymap.set("n", "<leader>fs", builtin.live_grep, { noremap = true, silent = true, desc = "Telescope grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true, silent = true, desc = "Telescope buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true, silent = true, desc = "Telescope help tags" })
    end
}
