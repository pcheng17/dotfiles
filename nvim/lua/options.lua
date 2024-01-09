local fn = vim.fn
local opt = vim.opt

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

opt.clipboard = "unnamedplus"
