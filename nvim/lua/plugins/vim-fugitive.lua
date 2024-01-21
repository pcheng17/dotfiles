return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs",  ":G status<cr>",       { silent = true, desc = "Git status" })
        vim.keymap.set("n", "<leader>gc",  ":G commit -v -q<cr>", { silent = true, desc = "Git commit" })
        -- vim.keymap.set("n", "<leader>gps", ":Git push<cr>",       { silent = true, desc = "Git push" })
        vim.keymap.set("n", "<leader>gvd", ":Gvdiffsplit<cr>",    { silent = true, desc = "Git vertical diff split" })
        vim.keymap.set("n", "<leader>gw",  ":Gwrite<cr>",         { silent = true, desc = "Git write" })
        vim.keymap.set("n", "<leader>gr",  ":Gread<cr>",          { silent = true, desc = "Git read" })
        vim.keymap.set("x", "do",          ":diffget<cr>",        { silent = true, desc = "Git diff get" })
        vim.keymap.set("x", "dp",          ":diffput<cr>",        { silent = true, desc = "Git diff put" })
    end
}
