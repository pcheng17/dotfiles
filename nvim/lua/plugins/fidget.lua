return {
    "j-hui/fidget.nvim",
    lazy = true,
    config = function()
        local fidget = require("fidget")
        fidget.setup({
            notification = {
                override_vim_notify = true,
                -- This is required for catppuccin
                window = {
                    winblend = 0,
                },
            },
        })
    end
}
