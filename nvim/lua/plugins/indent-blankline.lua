return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                scope = {
                    enabled = true,
                    show_start = false,
                },
                indent = { char = "│" },
                exclude = {
                    filetypes = { "help", "alpha", "dashboard", "Trouble", "lazy" }
                },
            })
        end
    }
}
