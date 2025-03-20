local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local parse = require("luasnip.util.parser").parse_snippet
local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix

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
local personal = {
    --stylua: ignore
    s( { trig = "sizet", dscr = "Fix size_t typo", snippetType = "autosnippet", wordTrig = true, }, { t("size_t"), }),
    s( { trig = "size_%", dscr = "Fix size_t typo", snippetType = "autosnippet", wordTrig = true, }, { t("size_t"), }),
    s( { trig = "u8", dscr = "uint8_t", }, { t("uint8_t"), }),
    s( { trig = "u16", dscr = "uint16_t", }, { t("uint16_t"), }),
    s( { trig = "u32", dscr = "uint32_t", }, { t("uint32_t"), }),
    s( { trig = "u64", dscr = "uint64_t", }, { t("uint64_t"), }),
    s( { trig = "i8", dscr = "int8_t", }, { t("int8_t"), }),
    s( { trig = "i16", dscr = "int16_t", }, { t("int16_t"), }),
    s( { trig = "i32", dscr = "int32_t", }, { t("int32_t"), }),
    s( { trig = "i64", dscr = "int64_t", }, { t("int64_t"), }),

    treesitter_postfix({
        trig = ".mv",
        dscr = "Wrap the previous expression with std::move",
        matchTSNode = {
            query = [[
                [
                  (call_expression)
                  (identifier)
                  (template_function)
                  (subscript_expression)
                  (field_expression)
                  (user_defined_literal)
                ] @prefix
            ]],
            query_lang = "cpp"
        },
    },{
        f(function(_, parent)
            local node_content = table.concat(parent.snippet.env.LS_TSMATCH, '\n')
            local replaced_content = ("std::move(%s)"):format(node_content)
            return vim.split(replaced_content, "\n", { trimempty = false })
        end)
    }),
    s(
        {
            trig = "guard",
            dscr = "Header include guard",
        },
        fmta(
            [[
                #ifndef <>
                #define <>

                <>

                #endif // <>
            ]],
            {
                i(1), rep(1), i(0), rep(1)
            }
        )
    ),
    s(
        {
            trig = "ns",
            dscr = "namespace",
        },
        fmta(
            [[
                namespace <>
                {

                <>

                } // <>
            ]],
            {
                i(1), i(0), rep(1)
            }
        )
    ),

    parse("ip", "${1:range}.begin(), $1.end()"),
    parse("mb", "[[maybe_unused]]"),
    parse("incq", '#include "${1:header}"'),
    parse("incb", "#include <${1:header}>"),
}

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
