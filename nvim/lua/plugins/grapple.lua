return {
    "cbochs/grapple.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons", lazy = true }
    },
    cmd = "Grapple",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
        { "<leader>a", "<cmd>Grapple tag<cr>", desc = "Grapple tag", silent = true },
        { "<leader><space>", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window", silent = true },
    },
    opts = {
        scope = "git"
    },
}
