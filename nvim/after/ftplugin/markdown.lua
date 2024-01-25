vim.opt_local.formatoptions:append({ "t" })
vim.opt_local.formatoptions:remove({ "l" })
vim.opt_local.textwidth = 100
vim.opt_local.spell = true
vim.opt_local.linebreak = true

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true, desc = "Move up by single line" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true, desc = "Move down by single line" })
