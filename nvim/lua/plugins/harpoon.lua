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

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { noremap = true, desc = "Add current file to harpoon" })
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { noremap = true, desc = "Open harpoon window" })
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { noremap = true, desc = "Go to harpoon 1" })
        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, { noremap = true, desc = "Go to harpoon 2" })
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, { noremap = true, desc = "Go to harpoon 3" })
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, { noremap = true, desc = "Go to harpoon 4" })

        -- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
    end
}
