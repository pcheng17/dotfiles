return {
    "epwalsh/obsidian.nvim",
    version = "*",
    enabled = false,
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/Documents/Notes"
            },
        },
    },
    config = function(_, opts)
        require("obsidian").setup(opts)
    end,
}
