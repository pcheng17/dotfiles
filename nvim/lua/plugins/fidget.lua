return {
    "j-hui/fidget.nvim",
    lazy = true,
    config = function()
        local fidget = require("fidget")
        fidget.setup({
            -- This is required for catppuccin
            notification = {
                override_vim_notify = true,
                window = {
                    winblend = 0,
                },
            },
        })
    end
}
