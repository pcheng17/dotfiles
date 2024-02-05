return {
    "epwalsh/obsidian.nvim",
    version = "*",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/Vaults/personal",
            },
            {
                name = "work",
                path = "~/Vaults/work",
            }
        },

        -- If you keep notes in a specific subirectory of your vault
        notes_subdir = "notes",

        -- Boolean or a function that takes a filename and returns a boolean
        -- False indicates that you want `obsidian.nvim` to manage frontmatter
        disable_frontmatter = false,

        -- Set to true to force `:ObsidianOpen` to bring the app to the foreground
        open_app_foreground = true,

        daily_notes = {
            folder = "journal",
            date_format = "%Y-%m-%d",
            alias_format = "%B %-d, %Y",
            template = "daily-note-template.md",
        },

        completion = {
            nvim_cmp = true,
            new_notes_location = "notes_subdir",
            prepend_note_id = false,
            prepend_note_path = true,
            use_path_only = false,
        },

        templates = {
            subdir = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            substitutions = {}
        },

        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            end
            if #suffix == 0 then
                return tostring(os.time())
            else
                return tostring(os.time()) .. "-" .. suffix
            end
        end,

        note_frontmatter_func = function(note)
            -- This is equivalent to the default frontmatter function.
            local out = { aliases = note.aliases, tags = note.tags }
            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end
            return out
        end,

        mappings = {
            ["gd"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { silent = true, expr = true }
            }
        }
    },
    config = function(_, opts)
        require("obsidian").setup(opts)
    end,
}
