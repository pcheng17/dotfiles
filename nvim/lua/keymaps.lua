local map = require("utils").map

map({ "n", "v" }, "<space>", "<nop>", {})

map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move up by single line" })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move down by single line" })

map("n", "<leader>lv", "<cmd>Lazy<cr>", { desc = "lazy.nvim" })
map("n", "<leader>lp", "<cmd>Ex ~/.dotfiles/nvim/lua/plugins<cr>", { desc = "Neovim plugins" })

map("n", "x", '"_x', { desc = "Delete into the black hole register" })
map("n", "Q", "@@", { desc = "Repeat the last macro" })
map("n", "J", "mzJ`z", { desc = "Append next line to current line with space" })
map("n", "<leader>fe", "<cmd>Ex<cr>", { desc = "Open native file explorer" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

map("n", "n", "nzzzv", { desc = "Move to next search match and center" })
map("n", "N", "Nzzzv", { desc = "Move to previous search match and center" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual block down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual block up" })
