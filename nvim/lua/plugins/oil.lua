return {
    'stevearc/oil.nvim',
    cmd = { "Oil" },
    keys = { "<leader>oi" },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('oil').setup({
            default_file_explorer = true,
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name)
                    return name == '.DS_Store'
                end
            },
        })

        vim.keymap.set("n", "<leader>oi",
            function()
                if vim.bo.ft ~= "oil" then
                    require("oil").open()
                else
                    require("oil").close()
                end
            end,
            { silent = true, desc = "Toggle Oil" })
    end,
}
