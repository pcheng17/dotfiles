vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")

-- Boostrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    -- stylua: ignore
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize plugins
require("lazy").setup("plugins")

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25


local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local myGroup = augroup("pcheng", {})

autocmd("TermOpen", {
    group = myGroup,
    pattern = "*",
    command = "startinsert",
})

