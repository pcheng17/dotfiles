require('lualine').setup({
    options = {
        always_divide_middle = true,
        icons_enabled = false,
        component_separators = { left = '|', right = '|' },
        section_separators = '',
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'filetype', 'encoding', 'fileformat'},
        lualine_y = {},
        lualine_z = {'location'}
    },
})
