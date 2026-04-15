return {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    keys = {
        { '<leader>tp', '<cmd>TypstPreviewToggle<cr>', desc = 'Typst Preview Toggle' },
        { '<leader>ts', '<cmd>TypstPreviewStop<cr>', desc = 'Typst Preview Stop' },
        { '<leader>tc', '<cmd>TypstPreviewFollowCursor<cr>', desc = 'Typst Preview Follow Cursor' },
    },
    version = '1.*',
    opts = {},  -- lazy.nvim will implicitly calls `setup {}`
}
