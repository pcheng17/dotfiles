vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.linebreak = true
-- vim.opt_local.conceallevel = 0

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true, desc = "Move up by single line" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true, desc = "Move down by single line" })
