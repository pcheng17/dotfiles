return {
    'stevearc/oil.nvim',
    cmd = { "Oil" },
    keys = {
        {
            "<leader>e",
            function()
                require("oil").open(nil, {
                    preview = {
                        vertical = true
                    },
                })
            end,
            mode = "n",
            desc = "Open Oil",
            silent = true,
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('oil').setup({
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name)
                    return name == '.DS_Store'
                end
            },
            win_options = {
                wrap = true,
            },
        })
    end,
}
