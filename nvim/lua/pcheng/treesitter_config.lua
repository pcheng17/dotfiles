require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = { "cpp", "python" },

    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true }
}

vim.api.nvim_set_keymap('n', '<leader><space>',
    [[<cmd>lua require('telescope.builtin').find_files()<cr>]],
    { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>;',
    [[<cmd>lua require('telescope.builtin').buffers()<cr>]],
    { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gr',
    [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],
    { noremap = true, silent = true})
