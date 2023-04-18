local opts = { silent = true }
local expr_opts = { silent = true, expr = true }

local function bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true }
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend('force', outer_opts, opts or {})
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

nnoremap = bind('n')
vnoremap = bind('v')
xnoremap = bind('x')
inoremap = bind('i')

vim.g.mapleader = " "

-- stylua: ignore start
nnoremap('J' , '10j' , { desc = 'Fast vertical movement' })
nnoremap('K' , '10k' , { desc = 'Fast vertical movement' })
vnoremap('J' , '10j' , { desc = 'Fast vertical movement' })
vnoremap('K' , '10k' , { desc = 'Fast vertical movement' })

nnoremap('x'          , '"_x'         , { desc = 'Delete into the black hole register' })
nnoremap('<esc>'      , ':noh<cr>'    , { desc = 'Turn off highlights' , silent = true })
nnoremap('Q'          , '@@'          , { desc = 'Repeat last macro used' })
nnoremap('Y'          , 'y$'          , { desc = 'Yank until end of line' })
nnoremap('U'          , 'mzJ`z'       , { desc = 'Append next line to current line with space' })
nnoremap('n'          , 'nzzzv'       , { desc = 'Jump to the next result, center line, open folds' })
nnoremap('N'          , 'Nzzzv'       , { desc = 'Jump to the previous result, center line, open folds' })
nnoremap('<leader>fd' , '<cmd>Ex<cr>' , { desc = 'Open file tree'      , silent = true })

vnoremap('<'          , '<gv'         , { desc = 'Indent lines out and keep selection' })
vnoremap('>'          , '>gv'         , { desc = 'Indent lines in and keep selection' })

nnoremap('<leader>p', '"_dP', { desc = 'Paste but delete to the black hole register' })
xnoremap('<leader>p', '"_dP', { desc = 'Paste but delete to the black hole register' })

nnoremap('++', ':vertical resize +5<cr>', { desc = 'Increase the width of the active split' })
nnoremap('--', ':vertical resize -5<cr>', { desc = 'Decrease the width of the active split' })

nnoremap('ga' , '<Plug>(EasyAlign)')
xnoremap('ga' , '<Plug>(EasyAlign)')
-- stylua: ignore end
