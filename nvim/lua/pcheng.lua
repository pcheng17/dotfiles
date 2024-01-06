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

-- Enter insert mode when opening a terminal
autocmd("TermOpen", {
    group = myGroup,
    pattern = "*",
    command = "startinsert",
})

-- Remove trailing whitespace
autocmd({"BufWritePre"}, {
    group = myGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Set global formatoptions
autocmd({"FileType"}, {
    group = myGroup,
    callback = function()
        vim.opt_local.formatoptions:remove({"r", "o"})
    end
})

autocmd('LspAttach', {
    group = myGroup,
    callback = function(e)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { buffer = e.buf, desc = "Go to definition" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = e.buf, desc = "Show hover help" })
        vim.keymap.set("n", "<leader>grr", function() vim.lsp.buf.references() end, { buffer = e.buf, desc = "Show references" })
        vim.keymap.set("n", "<leader>grn", function() vim.lsp.buf.rename() end, { buffer = e.buf, desc = "Rename symbol" })
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, { buffer = e.buf, desc = "Show signature help" })
    end
})

