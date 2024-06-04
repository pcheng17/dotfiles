local wezterm = require("wezterm")
local keys = require("keys")
local config = wezterm.config_builder()

-- Window configuration
config.initial_rows = 32
config.initial_cols = 128
config.window_background_opacity = 0.96
config.macos_window_background_blur = 0
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 12,
  right = 12,
  top = 32,
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

config.keys = keys

return config
