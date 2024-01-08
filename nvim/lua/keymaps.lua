vim.keymap.set("n", "<leader>lv", "<cmd>Lazy<cr>", { noremap = true, desc = "lazy.nvim" })
vim.keymap.set("n", "<leader>lp", "<cmd>Ex ~/.dotfiles/nvim/lua/plugins<cr>", { noremap = true, desc = "Neovim plugins" })

vim.keymap.set("n", "x", '"_x', { noremap = true, desc = "Delete into the black hole register" })
vim.keymap.set("n", "Q", "@@", { noremap = true, desc = "Repeat the last macro" })
vim.keymap.set("n", "J", "mzJ`z", { noremap = true, desc = "Append next line to current line with space" })
vim.keymap.set("n", "<leader>fe", "<cmd>Ex<cr>", { silent = true, desc = "Open native file explorer" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move visual block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move visual block up" })

