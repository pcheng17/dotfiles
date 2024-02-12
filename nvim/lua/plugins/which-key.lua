return {
    "folke/which-key.nvim",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        require("which-key").register({
            e = { "Toggle Oil" },
            f = {
                name = "File (Telescope)",
                e = { "Neotree Toggle" }
            },
            o = {
                i = { "Toggle Oil" },
                r = { "Overseer Run" },
                t = { "Overseer Toggle bottom" },
            },
            h = {
                p = { "Show Harpoon" }
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
            [","] = { "Add to Harpoon" },
        }, {
            prefix = "<leader>",
        })
    end
}
