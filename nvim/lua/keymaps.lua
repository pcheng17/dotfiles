local keymap = vim.keymap.set

keymap({ "n", "v" }, "<space>", "<nop>", { silent = true, desc = "Disable space" })

keymap("n", "<leader>fw", ":update<cr>",                              { silent = true, desc = "Write file" })
keymap("n", "<leader>lv", "<cmd>Lazy<cr>",                            { silent = true, desc = "lazy.nvim" })
keymap("n", "<leader>lp", "<cmd>Ex ~/.dotfiles/nvim/lua/plugins<cr>", { silent = true, desc = "Neovim plugins" })

keymap("n", "x",          '"_x',         { silent = true, desc = "Delete into the black hole register" })
keymap("n", "Q",          "@@",          { silent = true, desc = "Repeat the last macro" })
keymap("n", "J",          "mzJ`z",       { silent = true, desc = "Append next line to current line with space" })
keymap("n", "<leader>fx", "<cmd>Ex<cr>", { silent = true, desc = "Native file explorer" })

keymap("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Scroll up and center" })

keymap("n", "n", "nzzzv", { silent = true, desc = "Move to next search match and center" })
keymap("n", "N", "Nzzzv", { silent = true, desc = "Move to previous search match and center" })

keymap("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move visual block down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move visual block up" })
