return {
    "andrewferrier/debugprint.nvim",
    dependencies = {
        "echasnovski/mini.nvim", -- Needed to enable :ToggleCommentDebugPrints for NeoVim <= 0.9
        "nvim-treesitter/nvim-treesitter" -- Needed to enable treesitter for NeoVim 0.8
    },
    opts = {
        keymaps = {
            normal = {
                plain_below = "<leader>dp",
                plain_above = "<leader>dP",
                variable_below = "<leader>dv",
                variable_above = nil,
                variable_below_alwaysprompt = nil,
                variable_above_alwaysprompt = nil,
                textobj_below = nil,
                textobj_above = nil,
                toggle_comment_debug_prints = "<leader>dc",
                delete_debug_prints = "<leader>dd",
            },
            visual = {
                variable_below = "<leader>dv",
                variable_above = nil,
            },
        },
        commands = {
            toggle_comment_debug_prints = "ToggleCommentDebugPrints",
            delete_debug_prints = "DeleteDebugPrints",
        },
    },
    version = "*"
}
