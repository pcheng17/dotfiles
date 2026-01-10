local M = {}

-- Diagnostic severities
M.diagnostics = {
    Error = '',
    Warn = '',
    Hint = '',
    Info = '',
}

-- For folding
M.arrows = {
    right = '',
    left = '',
    up = '',
    down = '',
}

-- LSP symbol kinds
-- I took some of these from: https://github.com/onsails/lspkind.nvim
M.symbol_kinds = {
    Array = '󰅪',
    Class = '󰠱',
    Color = '󰏘',
    Constant = '󰏿',
    Constructor = '',
    Enum = '',
    EnumMember = '',
    Event = '',
    Field = '󰜢',
    File = '󰈙',
    Folder = '󰉋',
    Function = '󰊕',
    Interface = '',
    Keyword = '󰌋',
    Method = '󰆧',
    Module = '',
    Operator = '󰆕',
    Property = '󰜢',
    Reference = '󰈇',
    Snippet = '',
    Struct = '󰙅',
    Text = '',
    TypeParameter = '',
    Unit = '',
    Value = '',
    Variable = '󰀫',
}

-- Shared icons that don't really fit into a category
M.misc = {
    bug = '',
    ellipsis = '…',
    git = '',
    search = '',
    vertical_bar = '│',
}

return M
