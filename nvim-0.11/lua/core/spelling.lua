-- Get the list of .add files in the spell directory
local spell_dir = vim.fn.stdpath('config') .. '/spell'
local add_files = vim.fn.globpath(spell_dir, '*.add', false, true)

for _, add_file in ipairs(add_files) do
    local spl_file = add_file .. '.spl'
    if vim.fn.filereadable(add_file) == 1 then
        -- Check if the .spl file is not readable or if the .add file is newer than the .spl file
        if vim.fn.filereadable(spl_file) == 0 or vim.fn.getftime(add_file) > vim.fn.getftime(spl_file) then
            vim.cmd('mkspell! ' .. vim.fn.fnameescape(add_file))
        end
    end
end
