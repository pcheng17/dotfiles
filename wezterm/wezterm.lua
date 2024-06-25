local wezterm = require("wezterm")
local config = wezterm.config_builder()
-- local sessionizer = require("sessionizer")

-- Window configuration
config.initial_rows = 32
config.initial_cols = 128
-- config.window_background_opacity = 0.93
-- config.macos_window_background_blur = 30
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 16,
  right = 16,
  top = 30,
  bottom = 8,
}

-- Tab bar configuration
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

-- Font configuration
config.color_scheme = "Catppuccin Mocha"

local currentSetup = "personal-laptop"
-- local currentSetup = "personal-laptop-widescreen"
-- local currentSetup = "work-laptop"
-- local currentSetup = "work-laptop-widescreen"

if currentSetup == "personal-laptop" then
  config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono", { weight = "Light" })
  config.font_size = 14.0
  config.line_height = 1.1
elseif currentSetup == "personal-laptop-widescreen" then
  config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono", { weight = "Regular" })
  config.font_size = 15.5
  config.line_height = 1.2
elseif currentSetup == "work-laptop" then
  config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono", { weight = "Light" })
  config.font_size = 14.0
  config.line_height = 1.2
elseif currentSetup == "work-laptop-widescreen" then
  config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono", { weight = "Regular" })
  config.font_size = 15.5
  config.line_height = 1.2
end

-- Misc
config.scrollback_lines = 10000
config.prefer_to_spawn_tabs = true
config.audible_bell = "Disabled"

-- Command palette
-- config.command_palette_rows = 10
-- config.command_palette_font_size = 15.5
-- config.command_palette_bg_color = "#44382D"
-- config.command_palette_fg_color = "#c4a389"

-- config.leader = { key = "Space", mods = "CTRL" }
config.keys = {
  -- Move cursor backward by one word
  {
    key = "LeftArrow",
    mods = "OPT",
    action = wezterm.action.SendKey({ key = "b", mods = "ALT" }),
  },
  -- Move cursor forward by one word
  {
    key = "RightArrow",
    mods = "OPT",
    action = wezterm.action.SendKey({ key = "f", mods = "ALT" }),
  },
  -- Case insensitive search
  {
    key = "f",
    mods = "CMD",
    action = wezterm.action.Search({ CaseInSensitiveString = "" })
  },
  -- Activate command palette
  {
    key = "p",
    mods = "CMD",
    action = wezterm.action.ActivateCommandPalette,
  },
  -- Sessionizer
  -- {
  --   key = "f",
  --   mods = "LEADER",
  --   action = wezterm.action_callback(sessionizer.toggle),
  -- },
}

return config
