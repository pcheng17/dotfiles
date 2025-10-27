-- Must set these first because some keymaps defined in plugins will need this
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("plugins")
require("options")
require("keymaps")
