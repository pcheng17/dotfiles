vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/nvim-env/bin/python3")
vim.g.netrw_liststyle = 1

vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.wrap = false

-- vim.opt.textwidth = 100
-- vim.opt.colorcolumn = "+1"
vim.opt.formatoptions = "cqnlj"

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.opt.conceallevel = 0
vim.opt.list = false
vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")
vim.opt.clipboard = "unnamedplus"

vim.opt.winborder = "rounded"

-- vim.cmd("colorscheme tokyonight")
-- vim.cmd("colorscheme rose-pine")
vim.cmd("colorscheme catppuccin")
-- vim.cmd("colorscheme nightfox")
-- vim.cmd("colorscheme duskfox")
-- vim.cmd("colorscheme vague")

