local fn = vim.fn
local g = vim.g
local opt = vim.opt

-- No longer needed as I'm trying out oil.nvim
-- g.netrw_banner = 0
-- g.netrw_browse_split = 0
-- g.netrw_winsize = 25

g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/nvim-env/bin/python3")

-- opt.guicursor = ""
opt.termguicolors = true

opt.cursorline = true

opt.nu = true
opt.relativenumber = true

opt.smartindent = true

opt.incsearch = true
opt.hlsearch = false

opt.wrap = false

opt.textwidth = 100
opt.colorcolumn = "+1"

opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true

opt.undodir = fn.stdpath("data") .. "/undodir"
opt.undofile = true
opt.swapfile = false

opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
opt.conceallevel = 0
opt.list = false
opt.scrolloff = 8
opt.isfname:append("@-@")

opt.clipboard = "unnamedplus"

-- vim.cmd("colorscheme tokyonight")
-- vim.cmd("colorscheme rose-pine")
vim.cmd("colorscheme catppuccin")
-- vim.cmd("colorscheme nightfox")
-- vim.cmd("colorscheme duskfox")
