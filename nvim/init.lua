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
vim.lsp.set_log_level("off")

require("lazy").setup("plugins", {
    change_detection = {
        enable = true,  -- Automatically check for config file changes and reload
        notify = false, -- Disable notifications whenever plugin changes are made
    }
})

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.commands")
require("core.spelling")
require("core.ui")

-- Protected calls because these files may not always exist
pcall(require, "secrets")
pcall(require, "roblox")
