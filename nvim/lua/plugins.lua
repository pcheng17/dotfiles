-- This file can be loaded by calling `require('plugins')` from your init.lua

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Colorscheme
    use {'dracula/vim', as = 'dracula'}

    use 'lukas-reineke/indent-blankline.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use 'nvim-lua/plenary.nvim' -- Required by telescope.nvim
    use 'nvim-telescope/telescope.nvim'
end)
