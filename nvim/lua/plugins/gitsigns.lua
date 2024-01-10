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
            end
        })
    end
}
