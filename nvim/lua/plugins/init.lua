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
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        init = function() 
            require('nvim-treesitter.configs').setup {
                -- A list of parser names, or "all"
                ensure_installed = { "c", "cpp", "lua", "python", "rust", "toml", "norg" },

                highlight = { enable = true },
                incremental_selection = { enable = true },
                textobjects = { enable = true }
            }
        end
    },
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        dependencies = {
            {'nvim-lua/plenary.nvim'}
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({})

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>;', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end,
    },
    {
        "nvim-neorg/neorg",
        -- This will automatically call `require("neorg").setup(opts)`
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.norg.dirman"] = {
                    config = {
                        workspaces = {
                            home = "~/notes/home",
                        }
                    }
                }
            },
        },
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        'nvim-lualine/lualine.nvim',
        -- This will automatically call `require("lualine").setup(opts)`
        opts = {
            options = {
                always_divide_middle = true,
                icons_enabled = true,
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
            }
        },
    },
    { 
        'lukas-reineke/indent-blankline.nvim',
        opts = {
            show_current_context = true,
        }
    },
    { 'junegunn/vim-easy-align' },
    { "tpope/vim-fugitive" },
    { "tpope/vim-surround" },
    { "norcalli/nvim-colorizer.lua" },
    { "windwp/nvim-autopairs", config = true }, -- See `config` under https://github.com/folke/lazy.nvim#-plugin-spec
    { "numToStr/Comment.nvim", config = true },
}
