return {
    "L3MON4D3/LuaSnip",
    enabled = false,
    lazy = false,
    config = function()
        require("luasnip.loaders.from_lua").lazy_load({
            paths = vim.fn.stdpath("config") .. "/snippets",
        })
        require("luasnip").config.set_config({
            history = true,
            enable_autosnippets = true,
            store_selection_keys = "<Tab>",
            region_check_events = "InsertEnter",
            delete_check_events = "TextChanged,InsertLeave",
        })
    end
}
