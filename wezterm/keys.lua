local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
  {
    -- Move cursor backward by one word
    key = 'LeftArrow',
    mods = 'OPT',
    action = act.SendKey { key = 'b', mods = 'ALT', },
  },
  {
    -- Move cursor forward by one word
    key = 'RightArrow',
    mods = 'OPT',
    action = act.SendKey { key = 'f', mods = 'ALT' },
  },
}

return keys
