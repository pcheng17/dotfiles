return {
    "folke/which-key.nvim",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        require("which-key").register({
            d = {
                name = "Debug print"
            },
            e = { "Toggle Oil" },
            f = {
                name = "File (fzf-lua)",
                e = { "Neotree Toggle" }
            },
            g = {
                name = "Git",
            },
            o = {
                i = { "Toggle Oil" },
                r = { "Overseer Run" },
                t = { "Overseer Toggle bottom" },
            },
            t = {
                name = "Trouble",
                t = { "Trouble Toggle" },
                n = { "Trouble Next" },
                p = { "Trouble Previous" }
            },
            l = {
                g = { "LazyGit" }
            },
        }, {
            prefix = "<leader>",
        })
    end
}
