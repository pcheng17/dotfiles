return {
    "lervag/vimtex",
    ft = { "tex", "latex" },
    config = function()
        vim.g.vimtex_view_method = "skim"
        vim.g.vimtex_quickfix_mode = 0
        vim.cmd("syntax enable")
    end
}
