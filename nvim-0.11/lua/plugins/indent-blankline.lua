return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        require("ibl").setup({
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
            },
            indent = { char = "│" },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "grapple",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "OverseerList",
                }
            },
        })
    end
}
