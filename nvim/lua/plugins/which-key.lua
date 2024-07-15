return {
    "folke/which-key.nvim",
    version = "v2.1.0",
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
            t = {
                name = "Trouble",
            },
            l = {
                g = { "LazyGit" }
            },
        }, {
            prefix = "<leader>",
        })
    end
}
