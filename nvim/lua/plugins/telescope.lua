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

        local function nmap(keys, func, desc)
            vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
        end

        local builtin = require("telescope.builtin")
        nmap("<leader>ff" , builtin.find_files         , "Telescope find files")
        nmap("<leader>fd" , builtin.git_files          , "Telescope git files")
        nmap("<leader>fs" , "<cmd>LiveGrepGitRoot<cr>" , "Telescope grep in git root")
        nmap("<leader>fa" , builtin.live_grep          , "Telescope grep")
        nmap("<leader>f;" , builtin.buffers            , "Telescope buffers")
        nmap("<leader>fh" , builtin.help_tags          , "Telescope help tags")
        nmap("<leader>fk" , builtin.keymaps            , "Telescope keymaps")
        nmap("<leader>?"  , builtin.oldfiles           , "Telescope oldfiles")
    end
}
