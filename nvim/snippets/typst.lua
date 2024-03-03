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

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s(
    {
      trig = "mk",
      dscr = "Inline math environment at the beginning of a line",
      snippetType = "autosnippet",
    },
    fmta("$<>$", {
      d(1, get_visual),
    }),
    { condition = line_begin }
  ),

  s(
    {
      trig = "([^%a])mk",
      dscr = "Inline math environment only when `mk` is not part of a word",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),

  s(
    {
      trig = "dm",
      dscr = "Block math environment at the beginning of a line",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        $
          <>
        $
        <>
      ]],
      { d(1, get_visual), i(0) }
    ),
    { condition = line_begin }
  ),

  s(
    {
      trig = "([^%a])dm",
      dscr = "Block math environment only when `dm` is not part of a word",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta(
      [[
        <>
        $
          <>
        $
        <>
      ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        d(1, get_visual),
        i(0),
      }
    )
  ),

  -- Implementing both `,.` and `.,` so I can be messy about how I roll those two keys.
  -- No matter what, I'll end up with the same outcome.
  --stylua: ignore
  s(
    {
      trig = "([%w])(,%.)",
      name = "Vector value",
      dscr = {
        "Uses the `vect` function to display vector notation. ",
        "This requires a `vect` command to be defined for the document."
      },
      regTrig = true, wordTrig = false, snippetType = "autosnippet",
    },
    fmta("bold(upright(<>))", { f(function(_, snip) return snip.captures[1] end) })
  ),
  --stylua: ignore
  s(
    {
      trig = "([%w])(%.,)",
      name = "Vector value",
      dscr = {
        "Uses the `vect` function to display vector notation. ",
        "This requires a `vect` command to be defined for the document."
      },
      regTrig = true, wordTrig = false, snippetType = "autosnippet",
    },
    fmta("bold(upright(<>))", { f(function(_, snip) return snip.captures[1] end) })
  ),
}
