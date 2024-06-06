local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Window configuration
config.initial_rows = 32
config.initial_cols = 128
config.window_background_opacity = 0.92
config.macos_window_background_blur = 30
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
config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono", { weight = "ExtraLight" })
config.font_size = 14.0
config.line_height = 1.1

-- Misc
config.scrollback_lines = 10000
config.prefer_to_spawn_tabs = true
config.audible_bell = "Disabled"

-- Command palette
-- config.command_palette_rows = 10
-- config.command_palette_font_size = 15.5
-- config.command_palette_bg_color = "#44382D"
-- config.command_palette_fg_color = "#c4a389"

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
    key = 'p',
    mods = 'CMD',
    action = wezterm.action.ActivateCommandPalette,
  },
}

return config
