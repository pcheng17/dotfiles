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

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins", {
    change_detection = {
        enbale = true,  -- Automatically check for config file changes and reload
        notify = false, -- Disable notifications whenever plugin changes are made
    }
})

require("options")
require("keymaps")
require("autocmds")

-- Conditionally require work-related stuff
-- pcall(require, "roblox")

