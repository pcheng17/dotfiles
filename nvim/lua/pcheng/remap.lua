local nnoremap = require('pcheng.keymap').nnoremap
local vnoremap = require('pcheng.keymap').vnoremap

nnoremap('<leader>fd', '<cmd>Ex<cr>')

nnoremap('<leader>fs', ':update<cr>')
nnoremap('<leader>qq', ':q<cr>')
nnoremap('<leader>fq', ':q<cr>')

-- Fast vertical movement
nnoremap('J', '10j')
nnoremap('K', '10k')

-- Easier navigation of splits
nnoremap('<C-h>', '<C-w>h')
nnoremap('<C-j>', '<C-w>j')
nnoremap('<C-k>', '<C-w>k')
nnoremap('<C-l>', '<C-w>l')

-- Append next line to current line with space but do not move cursor
nnoremap('U', 'mzJ`z')
nnoremap('U', 'mzJ`z')

-- Jump to next result, center line, open folds
nnoremap('n', 'nzzzv')
-- Jump to previous result, center line, open folds
nnoremap('N', 'Nzzzv')

-- Adjust the width of the active split
nnoremap('++', ':vertical resize +5<cr>')
nnoremap('--', ':vertical resize -5<cr>')

-- Keep selected block after indent
vnoremap('<', '<gv')
vnoremap('>', '>gv')

-- vim.keymap.set('n', '<leader>/', 'gcc', {desc = 'More ergonomic comment'})
-- vim.keymap.set('v', '<leader>/', 'gc', {desc = 'More ergonomic comment'})

vim.keymap.set({'n', 'x'}, '<leader>p', '"_dP', {desc = 'Paste, but delete to the black hole register'})

-- Yank until end of line
nnoremap('Y', 'y$')

-- Iterative word replacement via .
nnoremap('c*', '/\\<<C-R>=expand(\'<cword>\')<CR>\\>\\C<CR>``cgn')
nnoremap('c#', '/\\<<C-R>=expand(\'<cword>\')<CR>\\>\\C<CR>``cgN')

-- Repeat last macros used
nnoremap('Q', '@@')
