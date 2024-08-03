local globalSnippets = {
    { trigger = 'shebang', body = '#!/bin sh' }
}

local snippetsByFiletype = {
    cpp = {
        { trigger = "rbxtest", body = "RBX_AUTO_TEST_CASE(${1:name})\n{\n\t$0\n}"}
    }
}

local function get_buf_snips()
    local ft = vim.bo.filetype
    local snips = vim.list_slice(globalSnippets)

    if ft and snippetsByFiletype[ft] then
        vim.list_extend(snips, snippetsByFiletype[ft])
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

