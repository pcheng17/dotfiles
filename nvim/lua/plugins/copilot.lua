return {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = {
                -- Uncomment the line below if using copilot-cmp
                -- enabled = false,
                auto_trigger = true,
                keymap = {
                    accept = "<tab>",
                },
            },
            panel = {
                -- Uncomment the line below if using copilot-cmp
                -- enabled = false,
            },
        })
    end,
}
