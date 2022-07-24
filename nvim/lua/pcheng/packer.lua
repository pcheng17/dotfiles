-- This file can be loaded by calling `require('plugins')` from your init.lua

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Colorscheme
    use {'dracula/vim', as = 'dracula'}

    use 'lukas-reineke/indent-blankline.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'

    use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}

    use 'jiangmiao/auto-pairs'
    use 'ervandew/supertab'
    use 'junegunn/vim-easy-align'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-surround'
    use 'qpkorr/vim-bufkill'
    use 'terryma/vim-multiple-cursors'
    -- use 'mhinz/vim-grepper'
    -- use 'rking/ag.vim'
    -- use 'airblade/vim-rooter'
    -- use 'lervag/vimtex'
end)
