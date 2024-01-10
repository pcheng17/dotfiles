return {
    "voldikss/vim-floaterm",
    config = function()
        local map = require("utils").map
        map("n", "<F4>",  ":FloatermNew --height=0.8 --width=0.8<CR>",            { desc = "New floaterm" })
        map("t", "<F4>",  "<C-\\><C-n>:FloatermNew --height=0.8 --width=0.8<CR>", { desc = "New floaterm" })
        map("n", "<F5>",  ":FloatermPrev<CR>",                                    { desc = "Previous floaterm" })
        map("t", "<F5>",  "<C-\\><C-n>:FloatermPrev<CR>",                         { desc = "Previous floaterm" })
        map("n", "<F6>",  ":FloatermNext<CR>",                                    { desc = "Next floaterm" })
        map("t", "<F6>",  "<C-\\><C-n>:FloatermNext<CR>",                         { desc = "Next floaterm" })
        map("n", "<F12>", ":FloatermToggle<CR>",                                  { desc = "Toggle floaterm" })
        map("t", "<F12>", "<C-\\><C-n>:FloatermToggle<CR>",                       { desc = "Toggle floaterm" })
    end
}
