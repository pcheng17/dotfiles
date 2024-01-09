vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

require("lazy").setup("plugins")
require("options")
require("keymaps")

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25


local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
    group = augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
})

local myGroup = augroup("pcheng", { clear = true })

-- Enter insert mode when opening a terminal
autocmd({ "TermOpen" }, {
    group = myGroup,
    pattern = "*",
    command = "startinsert",
})

-- Remove trailing whitespace
autocmd({ "BufWritePre" }, {
    group = myGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Set global formatoptions
autocmd({ "FileType" }, {
    group = myGroup,
    callback = function()
        vim.opt_local.formatoptions:remove({ "r", "o" })
    end
})

autocmd('LspAttach', {
    group = augroup("UserLspConfig", { clear = true }),
    callback = function(e)
        local nmap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = e.buf, desc = desc })
        end
        local imap = function(keys, func, desc)
            vim.keymap.set("i", keys, func, { noremap = true, silent = true, buffer = e.buf, desc = desc })
        end

        -- `:Format` command local to the LSP buffer
        vim.api.nvim_buf_create_user_command(
            e.buf, "Format", function(_) vim.lsp.buf.format({ async = true }) end, { desc = "Format buffer" }
        )

        local telescope = require("telescope.builtin")
        nmap("gd"         , function() telescope.lsp_definitions() end    , "Go to definition")
        nmap("gr"         , function() telescope.lsp_references() end     , "Go to references")
        nmap("K"          , function() vim.lsp.buf.hover() end            , "Hover documentation")
        nmap("<leader>ca" , function() vim.lsp.buf.code_action() end      , "Code actions")
        nmap("<leader>rn" , function() vim.lsp.buf.rename() end           , "Rename symbol")
        nmap("<leader>ds" , function() vim.lsp.buf.document_symbol() end  , "Document symbols")
        nmap("<leader>ws" , function() vim.lsp.buf.workspace_symbol() end , "Workspace symbols")
        imap("<C-k>"      , function() vim.lsp.buf.signature_help() end   , "Signature help")
    end
})
