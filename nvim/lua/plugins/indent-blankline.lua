return {
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                show_current_context = true,
                filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
                -- show_current_context_start = true,
                -- show_trailing_blankline_indent = false,
            }
        end
    }
}
