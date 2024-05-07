return {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            enabled = vim.fn.executable("make") == 1,
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end
        }
    },
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
                require("telescope.builtin").live_grep({
                    search_dirs = { git_root },
                    prompt_title = "Live Grep (Git Root)"
                })
            end
        end

        vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

        -- local builtin = require("telescope.builtin")
        -- local keymap = vim.keymap.set
        -- keymap("n", "<leader>ff",  builtin.find_files,           { silent = true, desc = "Telescope find files" })
        -- keymap("n", "<leader>;",   builtin.git_files,            { silent = true, desc = "Telescope git files" })
        -- keymap("n", "<leader>.",   "<cmd>LiveGrepGitRoot<cr>",   { silent = true, desc = "Telescope grep in git root" })
        -- keymap("n", "<leader>'",   builtin.oldfiles,             { silent = true, desc = "Telescope oldfiles" })
        -- keymap("n", "<leader>fs",  builtin.live_grep,            { silent = true, desc = "Telescope grep" })
        -- keymap("n", "<leader>fu",  builtin.buffers,              { silent = true, desc = "Telescope buffers" })
        -- keymap("n", "<leader>fh",  builtin.help_tags,            { silent = true, desc = "Telescope help tags" })
        -- keymap("n", "<leader>fk",  builtin.keymaps,              { silent = true, desc = "Telescope keymaps" })
        -- keymap("n", "<leader>fm",  builtin.marks,                { silent = true, desc = "Telescope marks" })
        -- keymap("n", "<leader>fx",  builtin.commands,             { silent = true, desc = "Telescope commands" })
        -- keymap("n", "<leader>fch", builtin.command_history,      { silent = true, desc = "Telescope command history" })
        -- keymap("n", "<leader>fll", builtin.loclist,              { silent = true, desc = "Telescope loclist" })
        -- keymap("n", "<leader>fqf", builtin.quickfix,             { silent = true, desc = "Telescope quickfix" })
    end
}
