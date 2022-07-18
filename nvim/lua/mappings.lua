vim.keymap.set('n', 'J', '10j', {desc = 'Faster way to navigate down'})
vim.keymap.set('n', 'K', '10k', {desc = 'Faster way to navigate up'})

vim.keymap.set('n', '<leader>fs', ':update<cr>', {desc = 'Update'})
vim.keymap.set('n', '<leader>qq', ':q<cr>', {desc = 'Quit'})
vim.keymap.set('n', '<leader>fq', ':q<cr>', {desc = 'Force quit'})

vim.keymap.set('n', '++', ':vertical resize +5<cr>', {desc = 'Make active split wider'})
vim.keymap.set('n', '--', ':vertical resize -5<cr>', {desc = 'Make active split narrower'})

vim.keymap.set('n', '<C-h>', '<C-w>h', {desc = 'Move to the split to the left'})
vim.keymap.set('n', '<C-j>', '<C-w>j', {desc = 'Move to the split below'})
vim.keymap.set('n', '<C-k>', '<C-w>k', {desc = 'Move to the split above'})
vim.keymap.set('n', '<C-l>', '<C-w>l', {desc = 'Move to the split to the right'})

vim.keymap.set({'n', 'v'}, 'U', 'mzJ`z', {desc = 'Append next line to current line with a space, but don\'t move cursor'})
vim.keymap.set('n', 'n', 'nzzzv', {desc = 'Jump to next result, center line, and open folds'})
vim.keymap.set('n', 'N', 'Nzzzv', {desc = 'Jump to previous result, center line, and open folds'})

vim.keymap.set('v', '<', '<gv', {desc = 'More ergonomic outdent'})
vim.keymap.set('v', '>', '>gv', {desc = 'More ergonomic indent'})

vim.keymap.set('n', '<leader>/', 'gcc', {desc = 'More ergonomic comment'})
vim.keymap.set('v', '<leader>/', 'gc', {desc = 'More ergonomic comment'})

vim.keymap.set({'n', 'x'}, '<leader>p', '"_dP', {desc = 'Paste, but delete to the black hole register'})

vim.keymap.set('n', 'Y', 'y$', {desc = 'Yank until end of line'})

vim.keymap.set('n', 'c*', '/\\<<C-R>=expand(\'<cword>\')<CR>\\>\\C<CR>``cgn', {desc = 'Iterative word replace via .'})
vim.keymap.set('n', 'c#', '/\\<<C-R>=expand(\'<cword>\')<CR>\\>\\C<CR>``cgN', {desc = 'Iterative word replace via .'})

vim.keymap.set('n', 'Q', '@@', {desc = 'Repeat last macro used'})
