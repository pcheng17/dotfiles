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
    s(
        {
            trig = "sizet",
            dscr = "Auto-expand to size_t",
            snippetType = "autosnippet",
            wordTrig = true,
        },
        {
            t("size_t"),
            i(0)
        }
    ),
    s(
        {
            trig = "size_%",
            dscr = "Fix typo of size_t",
            snippetType = "autosnippet",
            wordTrig = true,
        },
        {
            t("size_t"),
            i(0)
        }
    ),
    s(
        {
            trig = "u8",
            dscr = "Auto-expand to uint8_t",
            snippetType = "autosnippet",
            wordTrig = true,
        },
        {
            t("uint8_t"),
            i(0)
        }
    ),
    s(
        {
            trig = "u16",
            dscr = "Auto-expand to uint16_t",
            snippetType = "autosnippet",
            wordTrig = true,
        },
        {
            t("uint16_t"),
            i(0)
        }
    ),
    s(
        {
            trig = "u32",
            dscr = "Auto-expand to uint32_t",
            snippetType = "autosnippet",
            wordTrig = true,
        },
        {
            t("uint32_t"),
            i(0)
        }
    ),
    s(
        {
            trig = "u64",
            dscr = "Auto-expand to uint64_t",
            snippetType = "autosnippet",
            wordTrig = true,
        },
        {
            t("uint64_t"),
            i(0)
        }
    ),
    s(
        {
            trig = "i8",
            dscr = "Auto-expand to int8_t",
            snippetType = "autosnippet",
            wordTrig = true,
        },
        {
            t("int8_t"),
            i(0)
        }
    ),
    s(
        {
            trig = "i16",
            dscr = "Auto-expand to int16_t",
            snippetType = "autosnippet",
            wordTrig = true,
        },
        {
            t("int16_t"),
            i(0)
        }
    ),
    s(
        {
            trig = "i32",
            dscr = "Auto-expand to int32_t",
            snippetType = "autosnippet",
            wordTrig = true,
        },
        {
            t("int32_t"),
            i(0)
        }
    ),
    s(
        {
            trig = "i64",
            dscr = "Auto-expand to int64_t",
            snippetType = "autosnippet",
            wordTrig = true,
        },
        {
            t("int64_t"),
            i(0)
        }
    ),

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

    parse("ip", "${1:range}.begin(), $1.end()"),
    parse("mb", "[[maybe_unused]]")
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
