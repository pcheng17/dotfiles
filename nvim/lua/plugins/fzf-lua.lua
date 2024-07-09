return {
    "ibhagwan/fzf-lua",
    lazy = false,
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    --stylua: ignore start
    keys = {
        { "<leader>;",  function() require("fzf-lua").files() end,           mode = "n", desc = "fzf files in cwd",    silent = true },
        { "<leader>'",  function() require("fzf-lua").buffers() end,         mode = "n", desc = "fzf buffers",         silent = true },
        { "<leader>/",  function() require("fzf-lua").grep() end,            mode = "n", desc = "fzf grep in cwd",     silent = true },
        { "<leader>fo", function() require("fzf-lua").oldfiles() end,        mode = "n", desc = "fzf oldfiles",        silent = true },
        { "<leader>fh", function() require("fzf-lua").helptags() end,        mode = "n", desc = "fzf help tags",       silent = true },
        { "<leader>fk", function() require("fzf-lua").keymaps() end,         mode = "n", desc = "fzf keymaps",         silent = true },
        { "<leader>fx", function() require("fzf-lua").commands() end,        mode = "n", desc = "fzf commands",        silent = true },
        { "<leader>fc", function() require("fzf-lua").command_history() end, mode = "n", desc = "fzf command history", silent = true },
        { "<leader>fm", function() require("fzf-lua").marks() end,           mode = "n", desc = "fzf marks",           silent = true },
        { "<leader>fl", function() require("fzf-lua").loclist() end,         mode = "n", desc = "fzf loclist",         silent = true },
        { "<leader>fq", function() require("fzf-lua").quickfix() end,        mode = "n", desc = "fzf quickfix",        silent = true },
        {
            "<leader>*",
            function()
                require("fzf-lua").grep({ search = vim.fn.expand("<cword>") })
            end,
            mode = "n", desc = "fzf grep for current word", silent = true
        },
    --stylua: ignore end
    },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            keymap = {
                fzf = {
                    ["ctrl-q"] = "select-all+accept",
                },
            },
        })
    end
}
