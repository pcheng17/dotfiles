local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local merge_tables = require('utils').merge_tables

-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(_, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- Personal snippets
local personal = {}

-- Roblox-specific snippets
local roblox = {
  s(
    {
      trig = "rbxinfo",
      dscr = "Internal print statement for Roblox",
    },
    fmta(
      [[
        RBX::StandardOut::printf(RBX::MESSAGE_INFO, "[pcheng] <>");
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = "fflagif",
      dscr = "Fast Flag check",
    },
    fmta(
      [[
        if (FFlag::<>)
        {
            <>
        }
        else
        {
        <>
        }
      ]],
      {
        i(1),
        i(2),
        d(3, get_visual),
      }
    )
  ),
  s(
    {
      trig = "ffvar",
      dscr = "Fast flag variable",
    },
    fmta(
      [[
        FASTFLAGVARIABLE(<>, false);<>
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),
}

return merge_tables(personal, roblox)
