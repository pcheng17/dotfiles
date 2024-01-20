return {
    'akinsho/bufferline.nvim',
    enabled = true,
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options = {
                -- separator_style = "slant",
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        -- highlight = "Directory",
                        separator = true -- use a "true" to enable the default, or set your own character
                    }
                },
            },
        })

        vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { silent = true, desc = "Next buffer" })
        vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { silent = true, desc = "Previous buffer" })
    end
}
