return {
    "stevearc/oil.nvim",
    enabled = true,
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
    end
}
