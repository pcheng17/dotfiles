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

local tex = {}
tex.in_math = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

tex.in_comment = function()
  return vim.fn["vimtex#syntax#in_comment"]() == 1
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
        $$
          <>
        $$
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
        $$
          <>
        $$
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

  s(
    { trig = "beg", dscr = "Begin/end environemnts" },
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      { i(1), i(0), rep(1) }
    )
  ),

  s(
    { trig = "part", name = "Partial derivative" },
    fmta("\\frac{\\partial <>}{\\partial <>}<>", { i(1), i(2), i(0) })
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
    fmta("\\vect{<>}", { f(function(_, snip) return snip.captures[1] end) }),
    { condition = tex.in_math }
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
    fmta("\\vect{<>}", { f(function(_, snip) return snip.captures[1] end) }),
    { condition = tex.in_math }
  ),

  --stylua: ignore
  s(
    {
      trig = "sum",
      name = "summation",
      regTrig = true, wordTrig = false, snippetType = "autosnippet",
    },
    fmta("\\sum_{<>=<>}^{<>} <>", { i(1), i(2), i(3), i(0) }),
    { condition = tex.in_math }
  ),

  s(
    { trig = "_", name = "underscore", wordTrig = false, snippetType = "autosnippet" },
    fmta("_{<>}<>", { i(1), i(0) }),
    { condition = tex.in_math }
  ),

  s(
    { trig = "trans", name = "transpose", wordTrig = false, snippetType = "autosnippet" },
    t("^{\\top}"),
    { condition = tex.in_math }
  ),
  s(
    { trig = "->", name = "to", wordTrig = false, snippetType = "autosnippet" },
    t("\\to"),
    { condition = tex.in_math }
  ),
  s(
    { trig = "sr", name = "squared", wordTrig = false, snippetType = "autosnippet" },
    t("^2"),
    { condition = tex.in_math }
  ),
  s(
    { trig = "cb", name = "cubed", wordTrig = false, snippetType = "autosnippet" },
    t("^3"),
    { condition = tex.in_math }
  ),
  s(
    { trig = "inn", name = "in", wordTrig = false, snippetType = "autosnippet" },
    t("\\in"),
    { condition = tex.in_math }
  ),
  s(
    { trig = "xx", name = "times", wordTrig = false, snippetType = "autosnippet" },
    t("\\times"),
    { condition = tex.in_math }
  ),
  s(
    { trig = "RR", name = "R", wordTrig = false, snippetType = "autosnippet" },
    t("\\mathbb{R}"),
    { condition = tex.in_math }
  ),
  s(
    { trig = "QQ", name = "Q", wordTrig = false, snippetType = "autosnippet" },
    t("\\mathbb{Q}"),
    { condition = tex.in_math }
  ),
  s(
    { trig = "ZZ", name = "Z", wordTrig = false, snippetType = "autosnippet" },
    t("\\mathbb{Z}"),
    { condition = tex.in_math }
  ),
  s(
    { trig = "NN", name = "N", wordTrig = false, snippetType = "autosnippet" },
    t("\\mathbb{N}"),
    { condition = tex.in_math }
  ),

  -- Greek symbols
  s({ trig = ";a", snippetType = "autosnippet" }, {
    t("\\alpha"),
  }, { condition = tex.in_math }),
  s({ trig = ";b", snippetType = "autosnippet" }, {
    t("\\beta"),
  }, { condition = tex.in_math }),
  s({ trig = ";g", snippetType = "autosnippet" }, {
    t("\\gamma"),
  }, { condition = tex.in_math }),
  s({ trig = ";G", snippetType = "autosnippet" }, {
    t("\\Gamma"),
  }, { condition = tex.in_math }),
  s({ trig = ";d", snippetType = "autosnippet" }, {
    t("\\delta"),
  }, { condition = tex.in_math }),
  s({ trig = ";D", snippetType = "autosnippet" }, {
    t("\\Delta"),
  }, { condition = tex.in_math }),
  s({ trig = ";e", snippetType = "autosnippet" }, {
    t("\\epsilon"),
  }, { condition = tex.in_math }),
  s({ trig = ";ve", snippetType = "autosnippet" }, {
    t("\\varepsilon"),
  }, { condition = tex.in_math }),
  s({ trig = ";z", snippetType = "autosnippet" }, {
    t("\\zeta"),
  }, { condition = tex.in_math }),
  s({ trig = ";h", snippetType = "autosnippet" }, {
    t("\\eta"),
  }, { condition = tex.in_math }),
  s({ trig = ";o", snippetType = "autosnippet" }, {
    t("\\theta"),
  }, { condition = tex.in_math }),
  s({ trig = ";vo", snippetType = "autosnippet" }, {
    t("\\vartheta"),
  }, { condition = tex.in_math }),
  s({ trig = ";O", snippetType = "autosnippet" }, {
    t("\\Theta"),
  }, { condition = tex.in_math }),
  s({ trig = ";k", snippetType = "autosnippet" }, {
    t("\\kappa"),
  }, { condition = tex.in_math }),
  s({ trig = ";l", snippetType = "autosnippet" }, {
    t("\\lambda"),
  }, { condition = tex.in_math }),
  s({ trig = ";L", snippetType = "autosnippet" }, {
    t("\\Lambda"),
  }, { condition = tex.in_math }),
  s({ trig = ";m", snippetType = "autosnippet" }, {
    t("\\mu"),
  }, { condition = tex.in_math }),
  s({ trig = ";n", snippetType = "autosnippet" }, {
    t("\\nu"),
  }, { condition = tex.in_math }),
  s({ trig = ";x", snippetType = "autosnippet" }, {
    t("\\xi"),
  }, { condition = tex.in_math }),
  s({ trig = ";X", snippetType = "autosnippet" }, {
    t("\\Xi"),
  }, { condition = tex.in_math }),
  s({ trig = ";i", snippetType = "autosnippet" }, {
    t("\\pi"),
  }, { condition = tex.in_math }),
  s({ trig = ";I", snippetType = "autosnippet" }, {
    t("\\Pi"),
  }, { condition = tex.in_math }),
  s({ trig = ";r", snippetType = "autosnippet" }, {
    t("\\rho"),
  }, { condition = tex.in_math }),
  s({ trig = ";s", snippetType = "autosnippet" }, {
    t("\\sigma"),
  }, { condition = tex.in_math }),
  s({ trig = ";S", snippetType = "autosnippet" }, {
    t("\\Sigma"),
  }, { condition = tex.in_math }),
  s({ trig = ";t", snippetType = "autosnippet" }, {
    t("\\tau"),
  }, { condition = tex.in_math }),
  s({ trig = ";ph", snippetType = "autosnippet" }, {
    t("\\phi"),
  }, { condition = tex.in_math }),
  s({ trig = ";vph", snippetType = "autosnippet" }, {
    t("\\varphi"),
  }, { condition = tex.in_math }),
  s({ trig = ";Ph", snippetType = "autosnippet" }, {
    t("\\Phi"),
  }, { condition = tex.in_math }),
  s({ trig = ";c", snippetType = "autosnippet" }, {
    t("\\chi"),
  }, { condition = tex.in_math }),
  s({ trig = ";ps", snippetType = "autosnippet" }, {
    t("\\psi"),
  }, { condition = tex.in_math }),
  s({ trig = ";Ps", snippetType = "autosnippet" }, {
    t("\\Psi"),
  }, { condition = tex.in_math }),
  s({ trig = ";w", snippetType = "autosnippet" }, {
    t("\\omega"),
  }, { condition = tex.in_math }),
  s({ trig = ";W", snippetType = "autosnippet" }, {
    t("\\Omega"),
  }, { condition = tex.in_math }),

  s({ trig = "and", snippetType = "autosnippet" }, {
    t("\\quad \\text{and} \\quad"),
  }, { condition = tex.in_math }),

  -- Non-math-mode snippets
  s({ trig = "toc", snippetType = "autosnippet" }, {
    t("\\tableofcontents"),
  }, { condition = line_begin }),

  -- I tried to be generic, but I think this snippet prevents me from then creating a snippet that
  -- will handle something like ijk-th.
  -- s(
  --   {
  --     trig = "([^%a])([%a])th",
  --     name = "-th",
  --     regTrig = true,
  --     wordTrig = false,
  --     snippetType = "autosnippet",
  --   },
  --   fmta("<>$<>$-th", {
  --     f(function(_, snip) return snip.captures[1] end),
  --     f(function(_, snip) return snip.captures[2] end),
  --   })
  -- ),

  s({ trig = "ith", name = "i-th", snippetType = "autosnippet" }, {
    t("$i$-th"),
  }),
  s({ trig = "jth", name = "j-th", snippetType = "autosnippet" }, {
    t("$j$-th"),
  }),
  s({ trig = "kth", name = "k-th", snippetType = "autosnippet" }, {
    t("$k$-th"),
  }),
  s({ trig = "ijth", name = "ij-th", snippetType = "autosnippet" }, {
    t("$ij$-th"),
  }),
  s({ trig = "ijkth", name = "ijk-th", snippetType = "autosnippet" }, {
    t("$ij$-th"),
  }),
}
