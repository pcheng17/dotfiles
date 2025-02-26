local keymap = vim.keymap.set

-- stylua: ignore start
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move up by single line" })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move down by single line" })

keymap({ "n", "x" }, "<space>", "<nop>", { silent = true, desc = "Disable space" })
keymap({ "n", "x" }, "<del>",  "<nop>", { silent = true, desc = "Disable delete" })

keymap({ "n" }, "<leader>xx", ":!chmod +x %<cr>", { silent = true, desc = "Make file executable" })

keymap("n", "|+", ":res +5<cr>",      { silent = true, desc = "Increase window height" })
keymap("n", "|-", ":res -5<cr>",      { silent = true, desc = "Decrease window height" })
keymap("n", "_+", ":vert res +5<cr>", { silent = true, desc = "Increase window width" })
keymap("n", "_-", ":vert res -5<cr>", { silent = true, desc = "Decrease window width" })

keymap("n", "||", ":vsplit<cr>", { silent = true, desc = "Split window vertically" })
keymap("n", "__", ":split<cr>",  { silent = true, desc = "Split window horizontally" })

keymap({ "n", "x" }, "<leader>p", '"0p', { silent = true, desc = "Paste text from the last yank" })
keymap({ "n", "x" }, "<leader>wp", 'viw"0p', { silent = true, desc = "Paste text from the last yank over current word" })

keymap("n", "<leader>qq", ":Bdelete<cr>", { silent = true, desc = "Close current buffer" })
keymap("n", "<bs>", "<C-^>", { silent = true, desc = "Switch to previous buffer" })

-- keymap('n', '<C-h>', '<C-w>h', { silent = true, desc = "Move to left window" })
-- keymap('n', '<C-j>', '<C-w>j', { silent = true, desc = "Move to down window" })
-- keymap('n', '<C-k>', '<C-w>k', { silent = true, desc = "Move to up window" })
-- keymap('n', '<C-l>', '<C-w>l', { silent = true, desc = "Move to right window" })

keymap("n", "<leader>fw", ":update<cr>", { silent = true, desc = "Write file" })
keymap("n", "<leader>lv", "<cmd>Lazy<cr>", { silent = true, desc = "lazy.nvim" })
keymap("n", "<leader>lp", "<cmd>Ex ~/.dotfiles/nvim/lua/plugins<cr>", { silent = true, desc = "Neovim plugins" })

-- keymap("n", "x",          '"_x',         { silent = true, desc = "Delete into the black hole register" })
keymap("n", "J",          "mzJ`z",       { silent = true, desc = "Append next line to current line with space" })
-- keymap("n", "<leader>fx", "<cmd>Ex<cr>", { silent = true, desc = "Native file explorer" })
keymap("n", "gp",         "`[v`]",       { silent = true, desc = "Re-select last pasted text" })

keymap("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Scroll up and center" })

keymap("n", "n", "nzzzv", { silent = true, desc = "Move to next search match and center" })
keymap("n", "N", "Nzzzv", { silent = true, desc = "Move to previous search match and center" })

keymap("x", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move visual block down" })
keymap("x", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move visual block up" })

keymap("x", ">", ">gv", { silent = true, desc = "Increase indent of visual block" })
keymap("x", "<", "<gv", { silent = true, desc = "Decrease indent of visual block" })

keymap("n", "[q", ":cprev<cr>", { silent = true, desc = "Move to previous quickfix item" })
keymap("n", "]q", ":cnext<cr>", { silent = true, desc = "Move to next quickfix item" })
-- stylua: ignore end
