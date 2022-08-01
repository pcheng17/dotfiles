local nnoremap = require('keymap').nnoremap

function smart_find_files()
    local is_git = os.execute("git status &>/dev/null")
    if (is_git == 0) then
        vim.cmd(":Telescope git_files")
    else
        vim.cmd(":Telescope find_files")
    end
end

nnoremap('<leader><space>', smart_find_files)
nnoremap('<leader>;', '<cmd> Telescope buffers <cr>')
nnoremap('<leader>gr', '<cmd> Telescope live_grep <cr>')
