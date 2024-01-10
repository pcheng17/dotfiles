return {
    "voldikss/vim-floaterm",
    config = function()
        local keymap = vim.keymap.set
        keymap("n", "<F4>",  ":FloatermNew --height=0.8 --width=0.8<CR>",            { silent = true, desc = "New floaterm" })
        keymap("t", "<F4>",  "<C-\\><C-n>:FloatermNew --height=0.8 --width=0.8<CR>", { silent = true, desc = "New floaterm" })
        keymap("n", "<F5>",  ":FloatermPrev<CR>",                                    { silent = true, desc = "Previous floaterm" })
        keymap("t", "<F5>",  "<C-\\><C-n>:FloatermPrev<CR>",                         { silent = true, desc = "Previous floaterm" })
        keymap("n", "<F6>",  ":FloatermNext<CR>",                                    { silent = true, desc = "Next floaterm" })
        keymap("t", "<F6>",  "<C-\\><C-n>:FloatermNext<CR>",                         { silent = true, desc = "Next floaterm" })
        keymap("n", "<F12>", ":FloatermToggle<CR>",                                  { silent = true, desc = "Toggle floaterm" })
        keymap("t", "<F12>", "<C-\\><C-n>:FloatermToggle<CR>",                       { silent = true, desc = "Toggle floaterm" })
    end
}
