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

-- Conditionally require work-related stuff
pcall(require, "roblox")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
    group = augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
})

local MyGroup = augroup("pcheng", { clear = true })

-- Enter insert mode when opening a terminal
autocmd({ "BufWinEnter", "WinEnter" }, {
    group = MyGroup,
    pattern = "term://*",
    command = "startinsert",
})

-- Remove trailing whitespace
-- The callback function restores the cursor back to its original position after all
-- trailing whitespace has been removed.
autocmd({ "BufWritePre" }, {
    group = MyGroup,
    pattern = "*",
    callback = function()
        local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
        vim.api.nvim_exec('%s/\\s\\+$//e', false)
        vim.api.nvim_win_set_cursor(0, {row, col})
    end
})

-- Set global formatoptions
autocmd({ "FileType" }, {
    group = MyGroup,
    callback = function()
        vim.opt_local.formatoptions:remove({ "r", "o" })
    end
})

autocmd({ "FileType" }, {
    group = augroup("TextFileGroup", { clear = true }),
    pattern = { "*.md", "*.txt" },
    callback = function()
        vim.opt_local.linebreak = true
    end
})

autocmd('LspAttach', {
    group = augroup("UserLspConfig", { clear = true }),
    callback = function(e)
        local keymap = function(mode, lhs, rhs, opts)
            local options = { buffer = e.buf, silent = true }
            if opts then
                options = vim.tbl_extend("force", options, opts)
            end
            vim.keymap.set(mode, lhs, rhs, options)
        end

        -- `:Format` command local to the LSP buffer
        vim.api.nvim_buf_create_user_command(
            e.buf, "Format", function(_) vim.lsp.buf.format({ async = true }) end, { desc = "Format buffer" }
        )

        local telescope = require("telescope.builtin")
        keymap("n", "gd",         function() telescope.lsp_definitions() end,       { desc = "Go to definition" })
        keymap("n", "gr",         function() telescope.lsp_references() end,        { desc = "Go to references" })
        keymap("n", "K",          function() vim.lsp.buf.hover() end,               { desc = "Hover documentation" })
        keymap("n", "<leader>ca", function() vim.lsp.buf.code_action() end,         { desc = "Code actions" })
        keymap("n", "<leader>rn", function() vim.lsp.buf.rename() end,              { desc = "Rename symbol" })
        keymap("n", "<leader>ds", function() telescope.lsp_document_symbols() end,  { desc = "Document symbols" })
        keymap("n", "<leader>ws", function() telescope.lsp_workspace_symbols() end, { desc = "Workspace symbols" })
        keymap("i", "<C-k>",      function() vim.lsp.buf.signature_help() end,      { desc = "Signature help" })
    end
})
