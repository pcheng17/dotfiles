return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})

        -- Basic telescope configuration
        -- local conf = require("telescope.config").values
        -- local function toggle_telescope(harpoon_files)
        --     local file_paths = {}
        --     for _, item in ipairs(harpoon_files.items) do
        --         table.insert(file_paths, item.value)
        --     end

        --     require("telescope.pickers").new({}, {
        --         prompt_title = "Harpoon",
        --         finder = require("telescope.finders").new_table({
        --             results = file_paths,
        --         }),
        --         previewer = conf.file_previewer({}),
        --         sorter = conf.generic_sorter({}),
        --     }):find()
        -- end

        local keymap = vim.keymap.set
        keymap("n", "<leader>ha", function() harpoon:list():append() end,                      { silent = true, desc = "Add current file to harpoon" })
        keymap("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { silent = true, desc = "Open harpoon window" })
        keymap("n", "<C-h>",      function() harpoon:list():select(1) end,                     { silent = true, desc = "Go to harpoon 1" })
        keymap("n", "<C-j>",      function() harpoon:list():select(2) end,                     { silent = true, desc = "Go to harpoon 2" })
        keymap("n", "<C-k>",      function() harpoon:list():select(3) end,                     { silent = true, desc = "Go to harpoon 3" })
        keymap("n", "<C-l>",      function() harpoon:list():select(4) end,                     { silent = true, desc = "Go to harpoon 4" })

        -- map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Open harpoon window" }
    end
}
