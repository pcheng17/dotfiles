local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
    desc = "Highlight yanked text",
    group = augroup('YankHighlight', { clear = true }),
    pattern = '*',
    callback = function()
        vim.highlight.on_yank()
    end,
})

autocmd({ "FileType" }, {
    desc = "Set formatoptions",
    group = augroup("UserFormatOptions", { clear = true }),
    pattern = "*",
    callback = function(args)
        if args.match ~= "markdown" and args.match ~= "tex" and args.match ~= "text" and args.match ~= "typst" then
            vim.opt.formatoptions = "cqnlj"
        else
            vim.opt_local.formatoptions = "tcqnj"
        end
    end
})

autocmd({ "BufRead", "BufNewFile" }, {
    desc = "Set jsonl files to be treated as json",
    group = augroup("UserJsonlFileType", { clear = true }),
    pattern = "*.jsonl",
    callback = function()
        vim.bo.filetype = "json"
    end
})

local MyGroup = augroup("pcheng", { clear = true })

autocmd({ "FileType" }, {
    pattern = "oil",
    callback = function()
        vim.opt_local.colorcolumn = ""
    end
})

autocmd({ "BufWinEnter", "WinEnter" }, {
    desc = "Enter insert mode when opening a terminal",
    group = MyGroup,
    pattern = "term://*",
    command = "startinsert",
})

autocmd({ "BufWritePre" }, {
    desc = "Remove trailing whitespace without moving the cursor",
    group = MyGroup,
    pattern = "*",
    callback = function()
        local unpack = table.unpack or unpack
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        vim.api.nvim_exec('%s/\\s\\+$//e', false)
        vim.api.nvim_win_set_cursor(0, {row, col})
    end
})

autocmd({ "BufReadPost" }, {
    desc = "Open file at the last position it was edited earlier",
    group = MyGroup,
    pattern = "*",
    command = 'silent! normal! g`"zv'
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
        -- TODO: Do I want to use formatter.nvim instead?

        -- stylua: ignore start
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
        -- stylua: ignore end
    end
})
