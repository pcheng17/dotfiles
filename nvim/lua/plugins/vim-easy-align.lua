return {
    "junegunn/vim-easy-align",
    config = function()
        vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { noremap = false, desc = "Easy Align" })
        vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { noremap = false, desc = "Easy Align" })
    end
}
