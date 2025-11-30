return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('flutter-tools').setup({
            lsp = {
                color = {
                    enabled = true,
                }
            }
        })
    end,
}
