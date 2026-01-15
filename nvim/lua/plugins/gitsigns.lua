return {
    "lewis6991/gitsigns.nvim",
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

                keymap("n", "<leader>bl", function()
                    gs.blame_line({ full = true })
                end, { silent = true, desc = "Show full blame info of the current line" })

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
                keymap("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, { silent = true, desc = "Stage hunk" })
                keymap("v", "<leader>hr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, { silent = true, desc = "Reset hunk" })

                -- Text object
                keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { silent = true, desc = "Select hunk" })
            end
        })
    end
}
