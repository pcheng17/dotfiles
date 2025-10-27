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

autocmd("BufWritePost", {
    pattern = "*.tmux.conf",
    group = MyGroup,
    callback = function()
        vim.cmd('silent !tmux source-file ~/.tmux.conf ; tmux display-message "Reloaded ~/.tmux.conf"')
    end,
})
