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

-- Toggle markdown task list items with <CR>
-- Only works in normal mode on the current line.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.keymap.set("n", "<CR>", function()
            local line = vim.api.nvim_get_current_line()
            local new_line
            if line:match("%- %[ %]") then
                new_line = line:gsub("%- %[ %]", "- [x]", 1)
            elseif line:match("%- %[x%]") then
                new_line = line:gsub("%- %[x%]", "- [ ]", 1)
            end
            if new_line then
                vim.api.nvim_set_current_line(new_line)
            end
        end, { buffer = true })
    end,
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

autocmd({ "BufWritePre"}, {
    pattern = "*.dart",
    group = MyGroup,
    callback = function()
        vim.lsp.buf.format({ async = false })
    end
})

autocmd({ "BufWritePre"}, {
    pattern = "*.go",
    group = MyGroup,
    callback = function()
        vim.lsp.buf.format({ async = false })
    end
})

autocmd({ "BufReadPost" }, {
    desc = "Open file at the last position it was edited earlier",
    group = MyGroup,
    pattern = "*",
    command = 'silent! normal! g`"zv'
})

autocmd("BufWritePost", {
    pattern = "*/kitty.conf",
    group = MyGroup,
    callback = function()
        vim.cmd("silent !kill -SIGUSR1 $(pgrep -a kitty)")
    end,
})

autocmd("BufWritePost", {
    pattern = "*.tmux.conf",
    group = MyGroup,
    callback = function()
        vim.cmd('silent !tmux source-file ~/.tmux.conf ; tmux display-message "Reloaded ~/.tmux.conf"')
    end,
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

        vim.api.nvim_buf_create_user_command(
            e.buf, "Format", function(_) vim.lsp.buf.format({ async = true }) end, { desc = "Format buffer" }
        )

        keymap("n", "<leader>fmt", ":Format<CR>", { desc = "Format buffer", noremap = true, silent = true })

        keymap("n", "gd",
            function()
                require("fzf-lua").lsp_definitions({ jump1 = true })
            end,
            { desc = "Go to definition" })

        keymap("n", "gr",
            function()
                require("fzf-lua").lsp_references({
                    jump1 = true,
                    winopts = {
                        preview = {
                            hidden = "nohidden", -- I like to see some context
                            layout = "vertical", -- More likely to be able to see the full line of a context
                        },
                    },
                })
            end,
            { desc = "Go to references" })

        -- This splits the screen top and bottom
        local show_preview_v = {
            winopts = {
                height = 0.95,
                width = 0.90,
                preview = {
                    hidden = "nohidden", -- I like to see some context
                    layout = "vertical", -- More likely to be able to see the full line of a context
                    vertical = "down:55%",
                },
            },
        }

        -- This splits the screen left and right
        local show_preview_h = {
            winopts = {
                height = 0.95,
                width = 0.90,
                preview = {
                    hidden = "nohidden",
                    layout = "horizontal",
                },
            },
        }

        keymap("n", "<leader>ds", function()
            local cols, lines = vim.o.columns, vim.o.lines
            local use_horizontal = (cols > 120) and (cols > 4.0 * lines)
            local preview = (use_horizontal) and show_preview_h or show_preview_v
            require("fzf-lua").lsp_document_symbols(preview)
        end, { desc = "Document symbols" })

        keymap("n", "<leader>ws", function() require("fzf-lua").lsp_workspace_symbols() end,               { desc = "Workspace symbols" })
        keymap("n", "<leader>ic", function() require("fzf-lua").lsp_incoming_calls() end,                  { desc = "Incoming calls" })
        keymap("n", "<leader>oc", function() require("fzf-lua").lsp_outgoing_calls() end,                  { desc = "Outgoing calls" })
        keymap("n", "K",          function() vim.lsp.buf.hover() end,                                      { desc = "Hover documentation" })
        keymap("n", "<leader>rn", function() vim.lsp.buf.rename() end,                                     { desc = "Rename symbol" })
        keymap("i", "<C-k>",      function() vim.lsp.buf.signature_help() end,                             { desc = "Signature help" })
        keymap("n", "<leader>.",  function() require("fzf-lua").lsp_code_actions() end,                    { desc = "Code action" } )
        -- `gra` in Normal mode maps to `vim.lsp.buf.code_action()` by default
    end
})
