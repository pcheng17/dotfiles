if vim.fn.executable("tree-sitter") ~= 1 then
    vim.notify("tree-sitter CLI is not installed; skipping nvim-treesitter setup", vim.log.levels.WARN)
    return {}
end

local parsers = {
    "bash",
    "c",
    "cpp",
    "diff",
    "go",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "odin",
    "python",
    "query",
    "regex",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
}

local select_keymaps = {
    ["a="] = { "@assignment.outer",  "Select outer part of an assignment" },
    ["i="] = { "@assignment.inner",  "Select inner part of an assignment" },
    ["l="] = { "@assignment.lhs",    "Select left hand side of an assignment" },
    ["r="] = { "@assignment.rhs",    "Select right hand side of an assignment" },
    ["aa"] = { "@parameter.outer",   "Select outer part of a argument" },
    ["ia"] = { "@parameter.inner",   "Select inner part of a argument" },
    ["af"] = { "@call.outer",        "Select outer part of a function call" },
    ["if"] = { "@call.inner",        "Select inner part of a function call" },
    ["am"] = { "@function.outer",    "Select outer part of a method definition" },
    ["im"] = { "@function.inner",    "Select inner part of a method definition" },
    ["ac"] = { "@class.outer",       "Select outer part of a class" },
    ["ic"] = { "@class.inner",       "Select inner part of a class" },
    ["ai"] = { "@conditional.outer", "Select outer part of a conditional" },
    ["ii"] = { "@conditional.inner", "Select inner part of a conditional" },
    ["al"] = { "@loop.outer",        "Select outer part of a loop" },
    ["il"] = { "@loop.inner",        "Select inner part of a loop" },
}

local move_keymaps = {
    goto_next_start = {
        ["]f"] = { "@call.outer",        "Go to next function call start" },
        ["]m"] = { "@function.outer",    "Go to next method definition start" },
        ["]c"] = { "@class.outer",       "Go to next class start" },
        ["]i"] = { "@conditional.outer", "Go to next conditional start" },
        ["]l"] = { "@loop.outer",        "Go to next loop start" },
    },
    goto_next_end = {
        ["]F"] = { "@call.outer",        "Go to next function call end" },
        ["]M"] = { "@function.outer",    "Go to next method definition end" },
        ["]C"] = { "@class.outer",       "Go to next class end" },
        ["]I"] = { "@conditional.outer", "Go to next conditional end" },
        ["]L"] = { "@loop.outer",        "Go to next loop end" },
    },
    goto_previous_start = {
        ["[f"] = { "@call.outer",        "Go to previous function call start" },
        ["[m"] = { "@function.outer",    "Go to previous method definition start" },
        ["[c"] = { "@class.outer",       "Go to previous class start" },
        ["[i"] = { "@conditional.outer", "Go to previous conditional start" },
        ["[l"] = { "@loop.outer",        "Go to previous loop start" },
    },
    goto_previous_end = {
        ["[F"] = { "@call.outer",        "Go to previous function call end" },
        ["[M"] = { "@function.outer",    "Go to previous method definition end" },
        ["[C"] = { "@class.outer",       "Go to previous class end" },
        ["[I"] = { "@conditional.outer", "Go to previous conditional end" },
        ["[L"] = { "@loop.outer",        "Go to previous loop end" },
    },
}

local swap_keymaps = {
    swap_next = {
        ["<leader>na"] = { "@parameter.inner", "Swap argument with next" },
        ["<leader>nm"] = { "@function.outer",  "Swap method with next" },
    },
    swap_previous = {
        ["<leader>pa"] = { "@parameter.inner", "Swap argument with previous" },
        ["<leader>pm"] = { "@function.outer",  "Swap method with previous" },
    },
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup()
            require("nvim-treesitter").install(parsers)

            -- Highlighting is no longer automatic on the main branch. Start it per
            -- buffer, tolerating filetypes whose parser is absent or still installing.
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
                callback = function(ev)
                    pcall(vim.treesitter.start, ev.buf)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = { lookahead = true },
                move = { set_jumps = true },
            })

            for lhs, spec in pairs(select_keymaps) do
                vim.keymap.set({ "x", "o" }, lhs, function()
                    require("nvim-treesitter-textobjects.select").select_textobject(spec[1], "textobjects")
                end, { silent = true, desc = spec[2] })
            end

            for fn, keymaps in pairs(move_keymaps) do
                for lhs, spec in pairs(keymaps) do
                    vim.keymap.set({ "n", "x", "o" }, lhs, function()
                        require("nvim-treesitter-textobjects.move")[fn](spec[1], "textobjects")
                    end, { silent = true, desc = spec[2] })
                end
            end

            for fn, keymaps in pairs(swap_keymaps) do
                for lhs, spec in pairs(keymaps) do
                    vim.keymap.set("n", lhs, function()
                        require("nvim-treesitter-textobjects.swap")[fn](spec[1])
                    end, { silent = true, desc = spec[2] })
                end
            end
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = true,
        config = function()
            require("treesitter-context").setup({
                max_lines = 5,
                multiline_threshold = 1,
            })
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
