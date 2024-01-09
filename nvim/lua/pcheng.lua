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

local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = highlight_group,
  callback = function()
    vim.highlight.on_yank()
  end,
  pattern = '*',
})

local myGroup = augroup("pcheng", { clear = true })

-- Enter insert mode when opening a terminal
autocmd({"TermOpen"}, {
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
        local nmap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = e.buf, desc = desc })
        end
        local imap = function(keys, func, desc)
            vim.keymap.set("i", keys, func, { noremap = true, silent = true, buffer = e.buf, desc = desc })
        end
        nmap("gd"          , function() vim.lsp.buf.definition() end             , "Go to definition")
        nmap("K"           , function() vim.lsp.buf.hover() end                  , "Show hover help")
        nmap("<leader>gca" , function() vim.lsp.buf.code_action() end            , "Show code actions")
        nmap("<leader>grr" , function() vim.lsp.buf.references() end             , "Show references")
        nmap("<leader>grn" , function() vim.lsp.buf.rename() end                 , "Rename symbol")
        nmap("<space>fmt"  , function() vim.lsp.buf.format({ async = true }) end , "Format buffer")
        imap("<C-h>"       , function() vim.lsp.buf.signature_help() end         , "Show signature help")
    end
})

