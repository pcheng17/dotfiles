return {
    'kaarmu/typst.vim',
    ft = 'typst',
    enabled = false,
    config = function()
        vim.g.typst_pdf_viewer = 'skim'
    end
}
