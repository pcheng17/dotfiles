return {
    "cbochs/grapple.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons", lazy = true }
    },
    cmd = "Grapple",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
        { "<leader>g", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag", silent = true },
        { "<leader><space>", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window", silent = true },
    },
    opts = {
        scope = "cwd"
    },
}
