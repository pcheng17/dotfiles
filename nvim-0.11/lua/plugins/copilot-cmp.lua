return {
    "zbirenbaum/copilot-cmp",
    enabled = false,
    dependencies = {
        'zbirenbaum/copilot.lua',
    },
    config = function ()
        require("copilot_cmp").setup()
    end
}
