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

return {
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
}
