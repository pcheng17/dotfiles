return {
    "voldikss/vim-floaterm",
    config = function()
        vim.keymap.set("n", "<F4>",  ":FloatermNew --height=0.9 --width=0.9<CR>",                { noremap = true, silent = true, desc = "New floaterm" })
        vim.keymap.set("t", "<F4>",  "<C-\\><C-n>:FloatermNew<CR> --height=0.9 --width=0.9<CR>", { noremap = true, silent = true, desc = "New floaterm" })
        vim.keymap.set("n", "<F5>",  ":FloatermPrev<CR>",                                        { noremap = true, silent = true, desc = "Previous floaterm" })
        vim.keymap.set("t", "<F5>",  "<C-\\><C-n>:FloatermPrev<CR>",                             { noremap = true, silent = true, desc = "Previous floaterm" })
        vim.keymap.set("n", "<F6>",  ":FloatermNext<CR>",                                        { noremap = true, silent = true, desc = "Next floaterm" })
        vim.keymap.set("t", "<F6>",  "<C-\\><C-n>:FloatermNext<CR>",                             { noremap = true, silent = true, desc = "Next floaterm" })
        vim.keymap.set("n", "<F12>", ":FloatermToggle<CR>",                                      { noremap = true, silent = true, desc = "Toggle floaterm" })
        vim.keymap.set("t", "<F12>", "<C-\\><C-n>:FloatermToggle<CR>",                           { noremap = true, silent = true, desc = "Toggle floaterm" })
    end
}
