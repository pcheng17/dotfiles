return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {
        "Trouble",
    },
    keys = {
        {
            "<leader>to",
            function()
                require("trouble").open({
                    mode = "diagnostics",
                    preview = {
                        type = "split",
                        relative = "win",
                        position = "right",
                        size = 0.35,
                    },
                })
            end,
            desc = "Trouble open",
            silent = true,
        },
        {
            "<leader>td",
            function()
                require("trouble").open({
                    mode = "diagnostics",
                    preview = {
                        type = "split",
                        relative = "win",
                        position = "right",
                        size = 0.35,
                    },
                    filter = {
                        buf = 0,
                    },
                })
            end,
            desc = "Trouble document diagnostics",
            silent = true,
        },
        -- { "[d", function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Trouble previous", silent = true },
        -- { "]d", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Trouble next", silent = true },
        {
            "<leader>tq",
            function()
                require("trouble").close()
            end,
            desc = "Trouble close",
            silent = true,
        }
    },
    config = function()
        require("trouble").setup({})
    end
}
