return {
    "ThePrimeagen/harpoon",
    enabled = true,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>ha", function() require("harpoon"):list():add() end, mode = "n", desc = "Add to Harpoon", silent = true },
        { "<leader><space>",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            mode = "n", desc = "Harpoon open tags window", silent = true
        },
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = false,
                save_on_ui_close = false,
            },
        })

        -- keymap("n", "<M-h>",      function() harpoon:list():select(1) end,                     { silent = true, desc = "Harpoon 1" })
        -- keymap("n", "<M-j>",      function() harpoon:list():select(2) end,                     { silent = true, desc = "Harpoon 2" })
        -- keymap("n", "<M-k>",      function() harpoon:list():select(3) end,                     { silent = true, desc = "Harpoon 3" })
        -- keymap("n", "<M-l>",      function() harpoon:list():select(4) end,                     { silent = true, desc = "Harpoon 4" })
    end
}
