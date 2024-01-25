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

return M
