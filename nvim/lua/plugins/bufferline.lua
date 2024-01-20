return {
    'akinsho/bufferline.nvim',
    enabled = true,
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options = {
                separator_style = "slant"
            },

            vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { silent = true, desc = "Next buffer" }),
            vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { silent = true, desc = "Previous buffer" }),
        })
    end
}
