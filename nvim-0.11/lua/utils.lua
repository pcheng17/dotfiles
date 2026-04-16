local M = {}

M.load_keymaps = function(keymaps)
    local options = { silent = true }
    for mode, keymap in pairs(keymaps) do
        for lhs, value in pairs(keymap) do
            local rhs = value.rhs
            local opts = value.opts
            if opts then
                opts = vim.tbl_extend("force", options, opts)
            else
                opts = options
            end
            vim.keymap.set(mode, lhs, rhs, opts)
        end
    end
end

M.merge_tables = function(...)
    local tables = {...}
    local result = {}
    for _, tbl in ipairs(tables) do
        for _, v in pairs(tbl) do
            table.insert(result, v)
        end
    end
    return result
end

return M
