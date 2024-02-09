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
      trig = "snipt",
      dscr = "Snippet for a text snippet",
    },
    fmta(
      [[
        <>(<>, {t('<>')}<>
        <>)<>,
      ]],
      {
        c(1, { t("s"), t("autosnippet") }),
        c(2, { i(nil, "trig"), sn(nil, { t("{trig='"), i(1), t("'}") }) }),
        i(3, "text"),
        i(4, "opts"),
        i(5),
        i(0),
      }
    )
  ),

  s({ trig = "nosty", dscr = "Ignore styling" }, { t("--stylua: ignore") }),

  s({
    trig = "map",
    dscr = "Define Neovim keymap",
  }, {
    t("vim.keymap.set('"),
    i(1, "n"), -- Mode: 'n' for normal, 'i' for insert, etc.
    t("', '"),
    i(2, "<key>"), -- The key to map
    t("', '"),
    i(3, "<cmd>"), -- The command to execute
    t("', { silent = "),
    i(4, "true"), -- Silent flag
    t(", desc = '"),
    i(5, "Description"), -- Description of the keymap
    t("' })"),
  }),
}
