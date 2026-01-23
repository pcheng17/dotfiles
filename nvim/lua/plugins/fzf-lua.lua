-- Only used locally in this file for certain fzf-lua commands
local show_preview_v = {
    winopts = {
        height = 0.95,
        width = 0.90,
        preview = {
            hidden = "nohidden", -- I like to see some context
            layout = "vertical", -- More likely to be able to see the full line of a context
            vertical = "down:55%",
        },
    },
}

local show_preview_h = {
    winopts = {
        height = 0.95,
        width = 0.90,
        preview = {
            hidden = "nohidden", -- I like to see some context
            layout = "horizontal", -- More likely to be able to see the full line of a context
        },
    },
}

local function pick_preview()
    local cols, lines = vim.o.columns, vim.o.lines
    local use_horizontal = (cols > 120) and (cols > 3.7 * lines)
    return use_horizontal and show_preview_h or show_preview_v
end

return {
    "ibhagwan/fzf-lua",
    lazy = false,
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    --stylua: ignore start
    keys = {
        { "<leader>;",  function() require("fzf-lua").files(pick_preview()) end,              mode = "n", desc = "fzf files in cwd",                 silent = true },
        { "<leader>'",  function() require("fzf-lua").buffers() end,                        mode = "n", desc = "fzf buffers",                      silent = true },
        { "<leader>/",  function() require("fzf-lua").live_grep_native(pick_preview()) end, mode = "n", desc = "fzf grep in cwd",                  silent = true },
        { "<leader>gw", function() require("fzf-lua").grep_cword(pick_preview()) end,       mode = "n", desc = "fzf grep current word",            silent = true },
        { "<leader>gW", function() require("fzf-lua").grep_cWORD(pick_preview()) end,       mode = "n", desc = "fzf grep current WORD",            silent = true },
        { "<leader>gl", function() require("fzf-lua").grep_last(pick_preview()) end,        mode = "n", desc = "fzf grep in cwd for last pattern", silent = true },
        { "<leader>fo", function() require("fzf-lua").oldfiles() end,                       mode = "n", desc = "fzf oldfiles",                     silent = true },
        { "<leader>fh", function() require("fzf-lua").helptags() end,                       mode = "n", desc = "fzf help tags",                    silent = true },
        { "<leader>fk", function() require("fzf-lua").keymaps() end,                        mode = "n", desc = "fzf keymaps",                      silent = true },
        { "<leader>fx", function() require("fzf-lua").commands() end,                       mode = "n", desc = "fzf commands",                     silent = true },
        { "<leader>fc", function() require("fzf-lua").command_history() end,                mode = "n", desc = "fzf command history",              silent = true },
        { "<leader>fm", function() require("fzf-lua").marks() end,                          mode = "n", desc = "fzf marks",                        silent = true },
        { "<leader>fl", function() require("fzf-lua").loclist() end,                        mode = "n", desc = "fzf loclist",                      silent = true },
        { "<leader>fq", function() require("fzf-lua").quickfix() end,                       mode = "n", desc = "fzf quickfix",                     silent = true },
    --stylua: ignore end
    },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").register_ui_select()
        require("fzf-lua").setup({
            keymap = {
                builtin = {
                    ["<M-p>"] = "toggle-preview",
                },
                fzf = {
                    ["tab"] = "down",
                    ["shift-tab"] = "up",
                    ["ctrl-q"] = "select-all+accept",
                },
            },
            winopts = {
                height = 0.95,
                width = 0.90,
                preview = {
                    hidden = "hidden",
                    layout = "horizontal", -- More likely to be able to see more context
                },
            },
            defaults = {
                git_icons = false,
                file_icons = true,
            },
            hls = {
                backdrop = "Normal",
            }
        })
    end
}
