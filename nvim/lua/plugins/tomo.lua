return {
    "pcheng17/tomo.nvim",
    keys = {
        { "<leader>a;",
            function()
                require("tomo").put_at_end(";")
            end,
            desc = "Put semicolon at end of line", mode = "n", silent = true
        },
    },
    opts = {},
}
