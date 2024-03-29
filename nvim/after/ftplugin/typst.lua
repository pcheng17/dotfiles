vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.linebreak = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.textwidth = 100
-- vim.opt_local.conceallevel = 0

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'",
    { buffer = bufnr, expr = true, silent = true, desc = "Move up by single line" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'",
    { buffer = bufnr, expr = true, silent = true, desc = "Move down by single line" })
