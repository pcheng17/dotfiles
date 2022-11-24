require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "cpp", "lua", "python" },

    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true }
}
