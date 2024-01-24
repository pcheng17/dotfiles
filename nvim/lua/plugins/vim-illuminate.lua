return {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
        require("illuminate").configure({
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" }
            },
            filetypes_denylist = {
                "fugitive",
                "oil",
                "OverseerList",
                "markdown",
                "harpoon",
            },
        })
    end
}
