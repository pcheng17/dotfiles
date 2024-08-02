if false then
    vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { ctermbg = "none" })
    vim.api.nvim_set_hl(0, "NonText", { ctermbg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "none" })
    vim.api.nvim_set_hl(0, "StatusLine", { ctermbg = "none" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { ctermbg = "none" })

    vim.api.nvim_set_hl(0, "NeoTreeNormal", { ctermbg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { ctermbg = "none" })

    vim.api.nvim_set_hl(0, "TroubleNormal", { ctermbg = "none" })
end

vim.api.nvim_set_hl(0, "TreesitterContext", { ctermbg = "none" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { ctermbg = "none" })

-- For some reason, the same underline doesn't carry through across the entire line, so this fixes
-- the issue.
vim.api.nvim_set_hl(0, "TreesitterContextBottom", vim.api.nvim_get_hl(0, { name = "TreesitterContextLineNumberBottom" }))

local icons = require("icons")
for name, icon in pairs(icons.diagnostics) do
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl})
end
