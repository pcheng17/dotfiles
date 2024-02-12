return {
    "j-hui/fidget.nvim",
    config = function()
        require("fidget").setup({
            -- This is required for catppuccin
            notification = {
                window = {
                    winblend = 0,
                },
            },
        })
    end
}
