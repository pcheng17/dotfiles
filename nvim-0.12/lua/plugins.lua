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

local plugins = {
    {
        "nvim-tree/nvim-web-devicons"
    },

    {
        "catppuccin/nvim",
        enabled = true,
        config = function()
            require('catppuccin').setup({
                transparent_background = false,
                flavour = "mocha",
                no_italic = true,
                no_bold = true,
                styles = {
                    comments = { "italic" },
                    conditionals = {},
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                integrations = {
                    alpha = true,
                    cmp = true,
                    flash = true,
                    dap = true,
                    dap_ui = true,
                    fidget = true,
                    gitsigns = true,
                    illuminate = true,
                    lsp_trouble = true,
                    markdown = true,
                    mason = true,
                    -- noice = true,
                    native_lsp = { enabled = true },
                    neotree = true,
                    -- telescope = true,
                    semantic_tokens = true,
                    -- ts_rainbow = false,
                    treesitter = true,
                    treesitter_context = true,
                    which_key = true,
                }
            })
        end
    },

    {
        "stevearc/oil.nvim",
        enabled = true,
        config = function()
            require('oil').setup({
                default_file_explorer = true,
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                    is_always_hidden = function(name)
                        return name == '.DS_Store'
                    end
                },
                win_options = {
                    wrap = true,
                },
            })
        end
    },

    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
        config = function()
            local icons = require("icons")
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                    always_divide_middle = true,
                    icons_enabled = true,
                    component_separators = { left = "|", right = "|" },
                    section_separators = "",
                    -- component_separators = { left = '', right = ''},
                    -- section_separators = { left = '', right = ''},
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
                },
                sections = {
                    lualine_a = { "mode", },
                    lualine_b = {
                        { "branch", fmt = truncate_branch, icon = icons.misc.git },
                        "diff",
                        { "diagnostics",
                        symbols = {
                            error = icons.diagnostics.Error .. " ",
                            warn = icons.diagnostics.Warn .. " ",
                            info = icons.diagnostics.Info .. " ",
                            hint = icons.diagnostics.Hint .. " ",
                        }
                    },
                },
                lualine_c = {
                    { "filename", path = 1 },
                },
                lualine_x = { },
                lualine_y = {
                    "filetype",
                    "progress",
                    -- "encoding",
                    -- {
                        --     "fileformat",
                        --     icons_enabled = false,
                        -- }
                    },
                    lualine_z = {
                        {
                            "location", padding = { left = 1, right = 1 }
                        }
                    },
                }
            })
        end
    },

    {
        "lewis6991/gitsigns.nvim",
        enabled = true,
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 400,
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function keymap(mode, lhs, rhs, opts)
                        local options = { buffer = bufnr, silent = true }
                        if opts then
                            options = vim.tbl_extend("force", options, opts)
                        end
                        vim.keymap.set(mode, lhs, rhs, options)
                    end

                    -- Navigation
                    keymap("n", "]h", function()
                        if vim.wo.diff then return "]h" end
                        vim.schedule(function() gs.next_hunk() end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Next hunk" })

                    keymap("n", "[h", function()
                        if vim.wo.diff then return "[h" end
                        vim.schedule(function() gs.prev_hunk() end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Previous hunk" })

                    -- Actions
                    keymap("n", "<leader>hs", gs.stage_hunk, { silent = true, desc = "Stage hunk" })
                    keymap("n", "<leader>hr", gs.reset_hunk, { silent = true, desc = "Reset hunk" })
                    keymap("v", "<leader>hs", function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, { silent = true, desc = "Stage hunk" })
                    keymap("v", "<leader>hr", function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, { silent = true, desc = "Reset hunk" })

                    -- Text object
                    keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { silent = true, desc = "Select hunk" })
                end
            })
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = true,
        config = function()
            require("ibl").setup({
                scope = {
                    enabled = true,
                    show_start = false,
                    show_end = false,
                },
                indent = { char = "│" },
                exclude = {
                    filetypes = {
                        "help",
                        "alpha",
                        "dashboard",
                        "grapple",
                        "Trouble",
                        "trouble",
                        "lazy",
                        "mason",
                        "notify",
                        "OverseerList",
                    }
                }
		    })
        end
    },

    {
        "ibhagwan/fzf-lua",
        --stylua: ignore start
        keys = {
            { "<leader>;",  function() require("fzf-lua").files() end,                          mode = "n", desc = "fzf files in cwd",                 silent = true },
            { "<leader>'",  function() require("fzf-lua").buffers() end,                        mode = "n", desc = "fzf buffers",                      silent = true },
            { "<leader>/",  function() require("fzf-lua").live_grep_native(show_preview_v) end, mode = "n", desc = "fzf grep in cwd",                  silent = true },
            { "<leader>gw", function() require("fzf-lua").grep_cword(show_preview_v) end,       mode = "n", desc = "fzf grep current word",            silent = true },
            { "<leader>gW", function() require("fzf-lua").grep_cWORD(show_preview_v) end,       mode = "n", desc = "fzf grep current WORD",            silent = true },
            { "<leader>gl", function() require("fzf-lua").grep_last(show_preview_v) end,        mode = "n", desc = "fzf grep in cwd for last pattern", silent = true },
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
}

local function gh(path)
    return "https://github.com/" .. path
end

local enabled_plugins = {}
local plugin_configs = {}
local keymaps = {}

-- Load enabled plugins
for _, plugin in ipairs(plugins) do
    if type(plugin[1]) == "string" and (plugin.enabled == nil or plugin.enabled == true) then
        table.insert(enabled_plugins, { src = gh(plugin[1]) })
        if plugin.config then
            table.insert(plugin_configs, plugin.config)
        end
        if plugin.keys then
            for _, keymap in ipairs(plugin.keys) do
                table.insert(keymaps, keymap)
            end
        end
    end
end

vim.pack.add(enabled_plugins)

-- Configure plugins
for _, config in ipairs(plugin_configs) do
    config()
end

-- Set keymaps
for _, keymap in ipairs(keymaps) do
    local mode = keymap.mode or "n"
    local opts = { silent = keymap.silent or false, desc = keymap.desc or nil }
    vim.keymap.set(mode, keymap[1], keymap[2], opts)
end

