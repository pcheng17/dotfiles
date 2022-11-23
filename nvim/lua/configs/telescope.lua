local nnoremap = require('keymap').nnoremap

function smart_find_files()
    local is_git = os.execute("git status &>/dev/null")
    if (is_git == 0) then
        vim.cmd(":Telescope git_files")
    else
        vim.cmd(":Telescope find_files")
    end
end

local commands_table = {
    ['Tcol'] = 'colorscheme',
    ['Tdd']  = 'diagnostics',
    ['Tgc']  = 'git_commits',
    ['Tgb']  = 'git_branches',
    ['Tgs']  = 'git_status',
    ['Tgf']  = 'git_files',
}

for command, action in pairs(commands_table) do
    vim.cmd('command! ' .. command .. ' :Telescope ' .. action)
end

nnoremap('<leader><space>', smart_find_files)
nnoremap('<leader>;', '<cmd> Telescope buffers <cr>')
nnoremap('<leader>gr', '<cmd> Telescope live_grep <cr>')
