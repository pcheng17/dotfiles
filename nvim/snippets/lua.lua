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
  -- Simple text snippet
  s(
    "snipt",
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
}
