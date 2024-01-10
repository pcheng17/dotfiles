return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close,
                    },
                },
            },
        })

        -- Function to find the git root directory based on the current buffer's path
        local function find_git_root()
            -- Use the current buffer's path as the starting point for the git search
            local current_file = vim.api.nvim_buf_get_name(0)
            local current_dir
            local cwd = vim.fn.getcwd()
            -- If the buffer is not associated with a file, return nil
            if current_file == "" then
                current_dir = cwd
            else
                -- Extract the directory from the current file"s path
                current_dir = vim.fn.fnamemodify(current_file, ":h")
            end

            -- Find the Git root directory from the current file"s path
            local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
            if vim.v.shell_error ~= 0 then
                print "Not a git repository. Searching on current working directory"
                return cwd
            end
            return git_root
        end

        -- Custom live_grep function to search in git root
        local function live_grep_git_root()
            local git_root = find_git_root()
            if git_root then
                require("telescope.builtin").live_grep {
                    search_dirs = { git_root },
                }
            end
        end

        vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

        local map = require("utils").map
        local builtin = require("telescope.builtin")
        map("n", "<leader>ff" , builtin.find_files         , { desc = "Telescope find files" })
        map("n", "<leader>fd" , builtin.git_files          , { desc = "Telescope git files" })
        map("n", "<leader>fs" , "<cmd>LiveGrepGitRoot<cr>" , { desc = "Telescope grep in git root" })
        map("n", "<leader>fa" , builtin.live_grep          , { desc = "Telescope grep" })
        map("n", "<leader>f;" , builtin.buffers            , { desc = "Telescope buffers" })
        map("n", "<leader>fh" , builtin.help_tags          , { desc = "Telescope help tags" })
        map("n", "<leader>fk" , builtin.keymaps            , { desc = "Telescope keymaps" })
        map("n", "<leader>?"  , builtin.oldfiles           , { desc = "Telescope oldfiles" })
    end
}
