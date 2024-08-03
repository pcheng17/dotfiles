local function unindent(str)
    local lines = {}
    local min_indent = math.huge

    for line in str:gmatch("[^\r\n]+") do
        -- Check if the line is not entirely whitespace
        if line:match("%S") then
            local indent = line:match("^%s*"):len()
            if indent < min_indent then
                min_indent = indent
            end
        end
        table.insert(lines, line)
    end

    for i, line in ipairs(lines) do
        lines[i] = line:sub(min_indent + 1)
    end

    return table.concat(lines, "\n")
end

local globalSnippets = {
}

local snippetsByFiletype = {
    cpp = {
        {
            trigger = "rbxtestsuite",
            body =
                [[
                RBX_AUTO_TEST_SUITE(${1:name})

                $0

                RBX_AUTO_TEST_SUITE_END()
                ]]
        },
        {
            trigger = "rbxtest",
            body =
                [[
                    RBX_AUTO_TEST_CASE(${1:name})
                    {
                        $0
                    }
                ]]
        }

    }
}

local function get_buf_snips()
    local ft = vim.bo.filetype
    local snips = vim.list_slice(globalSnippets)

    if ft and snippetsByFiletype[ft] then
        vim.list_extend(snips, snippetsByFiletype[ft])
    end

    for _, snip in ipairs(snips) do
        snip.body = unindent(snip.body)
    end

    return snips
end

 local M = {}

-- cmp source for snippets to show up in completion menu
function M.register_cmp_source()
    local cmp_source = {}
    local cache = {}
    function cmp_source.complete(_, _, callback)
        local bufnr = vim.api.nvim_get_current_buf()
        if not cache[bufnr] then
            local completion_items = vim.tbl_map(function(s)
                ---@type lsp.CompletionItem
                local item = {
                    word = s.trigger,
                    label = s.trigger,
                    kind = vim.lsp.protocol.CompletionItemKind.Snippet,
                    insertText = s.body,
                    insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
                }
                return item
            end, get_buf_snips())

            cache[bufnr] = completion_items
        end

        callback(cache[bufnr])
    end

    require('cmp').register_source('snip', cmp_source)
end

return M
