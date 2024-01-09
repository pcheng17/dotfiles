return {
    "folke/which-key.nvim",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        require("which-key").register({
            ["<leader>f"] = { name = "File (Telescope)", _ = "which_key_ignore" },
        })
    end
}
