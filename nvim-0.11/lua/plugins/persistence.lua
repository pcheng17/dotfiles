return {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    keys = {
        { "<leader>ls", mode = { "n" }, function() require("persistence").load() end,              desc = "Load session for current directory" },
        -- { "<leader>qS", mode = { "n" }, function() require("persistence").load() end,              desc = "Select a session to load" },
        -- { "<leader>ql", mode = { "n" }, function() require("persistence").load({ last = true }) end, desc = "Load the last session" },
        -- { "<leader>qd", mode = { "n" }, function() require("persistence").stop() end,              desc = "Stop Persistence" },
    },
    opts = {
        dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
        options = { "buffers", "curdir", "winsize" },
        -- minimum number of file buffers that need to be open to save
        -- Set to 0 to always save
        need = 0,
        branch = true, -- use git branch to save session
    },
}
