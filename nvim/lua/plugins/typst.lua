return {
    'kaarmu/typst.vim',
    ft = 'typst',
    enabled = true,
    config = function()
        vim.g.typst_pdf_viewer = 'skim'
    end
}
