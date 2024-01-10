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
        local utils = require("utils")
        local map = function(mode, lhs, rhs, opts)
            local options = { buffer = e.buf }
            if opts then
                options = vim.tbl_extend("force", options, opts)
            end
            utils.map(mode, lhs, rhs, options)
        end

        -- `:Format` command local to the LSP buffer
        vim.api.nvim_buf_create_user_command(
            e.buf, "Format", function(_) vim.lsp.buf.format({ async = true }) end, { desc = "Format buffer" }
        )

        local telescope = require("telescope.builtin")
        map("n", "gd",         function() telescope.lsp_definitions() end,    { desc = "Go to definition" })
        map("n", "gr",         function() telescope.lsp_references() end,     { desc = "Go to references" })
        map("n", "K",          function() vim.lsp.buf.hover() end,            { desc = "Hover documentation" })
        map("n", "<leader>ca", function() vim.lsp.buf.code_action() end,      { desc = "Code actions" })
        map("n", "<leader>rn", function() vim.lsp.buf.rename() end,           { desc = "Rename symbol" })
        map("n", "<leader>ds", function() vim.lsp.buf.document_symbol() end,  { desc = "Document symbols" })
        map("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, { desc = "Workspace symbols" })
        map("i", "<C-k>",      function() vim.lsp.buf.signature_help() end,   { desc = "Signature help" })
    end
})
