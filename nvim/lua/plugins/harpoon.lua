return {
    "ThePrimeagen/harpoon",
    keys = {
        "<leader>,",
        "<leader>hp",
        "<M-h>",
        "<M-j>",
        "<M-k>",
        "<M-l>",
    },
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})

        local keymap = vim.keymap.set
        keymap("n", "<leader>,",  function() harpoon:list():append() end,                      { silent = true, desc = "Add to Harpoon" })
        keymap("n", "<leader>hp", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { silent = true, desc = "Show Harpoon" })
        keymap("n", "<M-h>",      function() harpoon:list():select(1) end,                     { silent = true, desc = "Harpoon 1" })
        keymap("n", "<M-j>",      function() harpoon:list():select(2) end,                     { silent = true, desc = "Harpoon 2" })
        keymap("n", "<M-k>",      function() harpoon:list():select(3) end,                     { silent = true, desc = "Harpoon 3" })
        keymap("n", "<M-l>",      function() harpoon:list():select(4) end,                     { silent = true, desc = "Harpoon 4" })
    end
}
