return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {
        "Trouble",
        "TroubleToggle"
    },
    keys = {
        { "<leader>tt", function() require("trouble").toggle() end, desc = "Trouble toggle", silent = true },
        { "<leader>td", function() require("trouble").toggle("document_diagnostics") end, desc = "Trouble document diagnostics", silent = true },
        { "[d", function() require("trouble").previous({ skip_groups = true, jump = true }) end, desc = "Trouble previous", silent = true },
        { "]d", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Trouble next", silent = true },
    },
    config = function()
        require("trouble").setup({})
    end
}
