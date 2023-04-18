return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        -- init = function()
        --     require('lualine').setup({
        --         options = {
        --             always_divide_middle = true,
        --             icons_enabled = true,
        --             component_separators = { left = '|', right = '|' },
        --             section_separators = '',
        --         },
        --         sections = {
        --             lualine_a = {'mode'},
        --             lualine_b = {'branch', 'diff', 'diagnostics'},
        --             lualine_c = {'filename'},
        --             lualine_x = {'filetype', 'encoding', 'fileformat'},
        --             lualine_y = {},
        --             lualine_z = {'location'}
        --         }
        --     })
        -- end,
    },
    { "tpope/vim-fugitive" },
    { "tpope/vim-surround" },
    { "norcalli/nvim-colorizer.lua" },
    { "windwp/nvim-autopairs", config = true }, -- See `config` under https://github.com/folke/lazy.nvim#-plugin-spec
    { "numToStr/Comment.nvim", config = true },
    { 'junegunn/vim-easy-align' },
}
