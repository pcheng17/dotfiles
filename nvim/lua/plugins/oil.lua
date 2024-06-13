return {
    'stevearc/oil.nvim',
    cmd = { "Oil" },
    keys = { "<leader>e" },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('oil').setup({
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name)
                    return name == '.DS_Store' or name == ".git"
                end
            },
            win_options = {
                wrap = true,
            },
        })

        vim.keymap.set("n", "<leader>e",
            function()
                -- if vim.bo.ft ~= "oil" then
                --     require("oil").open_float()
                -- else
                --     require("oil").close_float()
                -- end
                require("oil").toggle_float()
            end,
            { silent = true, desc = "Toggle Oil" })
    end,
}
