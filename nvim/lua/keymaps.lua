local keymap = vim.keymap.set

keymap({ "n", "v" }, "<space>", "<nop>", { silent = true, desc = "Disable space" })

keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move up by single line" })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move down by single line" })

keymap("n", "<leader>lv", "<cmd>Lazy<cr>",                            { silent = true, desc = "lazy.nvim" })
keymap("n", "<leader>lp", "<cmd>Ex ~/.dotfiles/nvim/lua/plugins<cr>", { silent = true, desc = "Neovim plugins" })

keymap("n", "<C-a>",      "ggVG",        { silent = true, desc = "Select all" })
keymap("n", "x",          '"_x',         { silent = true, desc = "Delete into the black hole register" })
keymap("n", "Q",          "@@",          { silent = true, desc = "Repeat the last macro" })
keymap("n", "J",          "mzJ`z",       { silent = true, desc = "Append next line to current line with space" })
keymap("n", "<leader>fe", "<cmd>Ex<cr>", { silent = true, desc = "Open native file explorer" })

keymap("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Scroll up and center" })

keymap("n", "n", "nzzzv", { silent = true, desc = "Move to next search match and center" })
keymap("n", "N", "Nzzzv", { silent = true, desc = "Move to previous search match and center" })

keymap("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move visual block down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move visual block up" })
