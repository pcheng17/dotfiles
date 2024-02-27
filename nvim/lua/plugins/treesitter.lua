return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- Pin at this version because of breaking changes that affects colorschemes
        version = "v0.9.2",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                indent = { enable = true },
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "diff",
                    "html",
                    "javascript",
                    "jsdoc",
                    "json",
                    "jsonc",
                    "latex",
                    "lua",
                    "luadoc",
                    "luap",
                    "markdown",
                    "markdown_inline",
                    "norg",
                    "python",
                    "query",
                    "regex",
                    "ruby",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        scope_incremental = false,
                        node_decremental = "<Del>",
                    }
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            ["a="] = { query = "@assignment.outer",  desc = "Select outer part of an assignment" },
                            ["i="] = { query = "@assignment.inner",  desc = "Select inner part of an assignment" },
                            ["l="] = { query = "@assignment.lhs",    desc = "Select left hand side of an assignment" },
                            ["r="] = { query = "@assignment.rhs",    desc = "Select right hand side of an assignment" },
                            ["aa"] = { query = "@parameter.outer",   desc = "Select outer part of a argument" },
                            ["ia"] = { query = "@parameter.inner",   desc = "Select inner part of a argument" },
                            ["af"] = { query = "@call.outer",        desc = "Select outer part of a function call" },
                            ["if"] = { query = "@call.inner",        desc = "Select inner part of a function call" },
                            ["am"] = { query = "@function.outer",    desc = "Select outer part of a method definition" },
                            ["im"] = { query = "@function.inner",    desc = "Select inner part of a method definition" },
                            ["ac"] = { query = "@class.outer",       desc = "Select outer part of a class" },
                            ["ic"] = { query = "@class.inner",       desc = "Select inner part of a class" },
                            ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                            ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
                            ["al"] = { query = "@loop.outer",        desc = "Select outer part of a loop" },
                            ["il"] = { query = "@loop.inner",        desc = "Select inner part of a loop" },
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- Whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]f"] = { query = "@call.outer",        desc = "Go to next function call start" },
                            ["]m"] = { query = "@function.outer",    desc = "Go to next method definition start" },
                            ["]c"] = { query = "@class.outer",       desc = "Go to next class start" },
                            ["]i"] = { query = "@conditional.outer", desc = "Go to next conditional start" },
                            ["]l"] = { query = "@loop.outer",        desc = "Go to next loop start" },
                        },
                        goto_next_end = {
                            ["]F"] = { query = "@call.outer",        desc = "Go to next function call end" },
                            ["]M"] = { query = "@function.outer",    desc = "Go to next method definition end" },
                            ["]C"] = { query = "@class.outer",       desc = "Go to next class end" },
                            ["]I"] = { query = "@conditional.outer", desc = "Go to next conditional end" },
                            ["]L"] = { query = "@loop.outer",        desc = "Go to next loop end" },
                        },
                        goto_previous_start = {
                            ["[f"] = { query = "@call.outer",        desc = "Go to previous function call start" },
                            ["[m"] = { query = "@function.outer",    desc = "Go to previous method definition start" },
                            ["[c"] = { query = "@class.outer",       desc = "Go to previous class start" },
                            ["[i"] = { query = "@conditional.outer", desc = "Go to previous conditional start" },
                            ["[l"] = { query = "@loop.outer",        desc = "Go to previous loop start" },
                        },
                        goto_previous_end = {
                            ["[F"] = { query = "@call.outer",        desc = "Go to previous function call end" },
                            ["[M"] = { query = "@function.outer",    desc = "Go to previous method definition end" },
                            ["[C"] = { query = "@class.outer",       desc = "Go to previous class end" },
                            ["[I"] = { query = "@conditional.outer", desc = "Go to previous conditional end" },
                            ["[L"] = { query = "@loop.outer",        desc = "Go to previous loop end" },
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>na"] = { query = "@parameter.inner", desc = "Swap argument with next" },
                            ["<leader>nm"] = { query = "@function.outer",  desc = "Swap method with next" },
                        },
                        swap_previous = {
                            ["<leader>pa"] = { query = "@parameter.inner", desc = "Swap argument with previous" },
                            ["<leader>pm"] = { query = "@function.outer",  desc = "Swap method with previous" },
                        },
                    },
                },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = false,
        config = function()
            vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey"})
            vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = true, sp = "Grey"})
            vim.keymap.set("n", "[x",
                function()
                    require("treesitter-context").go_to_context(vim.v.count1)
                end,
                { silent = true, desc = "Go to previous context" }
            )
        end,
    }
}
