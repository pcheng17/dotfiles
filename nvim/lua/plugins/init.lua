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
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "norcalli/nvim-colorizer.lua" },
  { "windwp/nvim-autopairs", config = true }, -- See `config` under https://github.com/folke/lazy.nvim#-plugin-spec
  { "numToStr/Comment.nvim", config = true },
  { 'junegunn/vim-easy-align' },
}
