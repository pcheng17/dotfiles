local plugins = {
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
    }
}

local function gh(path)
    return "https://github.com/" .. path
end

local enabled_plugins = {}
local plugin_configs = {}

-- Load enabled plugins
for index, plugin in ipairs(plugins) do
    if type(plugin[1]) == "string" and (plugin.enabled == nil or plugin.enabled == true) then
        table.insert(enabled_plugins, { src = gh(plugin[1]) })
        if plugin.config then
            table.insert(plugin_configs, plugin.config)
        end
    end
end

vim.pack.add(enabled_plugins)

-- Configure plugins
for index, config in ipairs(plugin_configs) do
    config()
end

