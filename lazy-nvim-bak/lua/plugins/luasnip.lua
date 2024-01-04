return {
  "L3MON4D3/LuaSnip",
  lazy = false,
  config = function()
    require("luasnip.loaders.from_lua").lazy_load({
      paths = vim.fn.stdpath("config") .. "/snippets",
    })
    require("luasnip").config.set_config({
      -- Not really sure what some of these actually do, but here's the documentation:
      -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#config-options
      -- I set these because I found a Reddit post where some of these settings here helped
      -- others solve some inconsistency issues.
      -- https://www.reddit.com/r/neovim/comments/12z0orb/unexpected_behavior_when_pressing_tab_in_insert/
      history = true,
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
      region_check_events = "InsertEnter",
      delete_check_events = "TextChanged,InsertLeave",
    })
  end,
}
