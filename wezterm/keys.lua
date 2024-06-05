local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
  -- Move cursor backward by one word
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = wezterm.action.SendKey({ key = 'b', mods = 'ALT' }),
  },
  -- Move cursor forward by one word
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = wezterm.action.SendKey({ key = 'f', mods = 'ALT' }),
  },
  -- Case insensitive search
  {
    key = 'f',
    mods = 'CMD',
    action = wezterm.action.Search({ CaseInSensitiveString = "" })
  }
}

return keys
