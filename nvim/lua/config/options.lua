-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local fn = vim.fn
local opt = vim.opt

opt.colorcolumn = "100"
opt.list = false
opt.scrolloff = 8
opt.shiftwidth = 4
opt.tabstop = 4
opt.undodir = fn.stdpath("data") .. "/undodir" -- set undo directory
opt.undofile = true -- enable/disable undo file creation
