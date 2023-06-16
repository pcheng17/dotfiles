-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "x", '"_x', { noremap = true, desc = "Delete into the black hole register" })
map("n", "Q", "@@", { noremap = true, desc = "Repeat the last macro" })
map("n", "U", "mzJ`z", { noremap = true, desc = "Append next line to current line with space" })
map("n", "<leader>fd", "<cmd>Ex<cr>", { silent = true, desc = "Open native file explorer" })

map({ "n", "x" }, "ga", "<Plug>(EasyAlign)")

map("n", "<leader>fs", "<cmd>update<cr>")
map("n", "<leader>qq", "<cmd>q<cr>")
map("n", "<leader>fq", "<cmd>q!<cr>")
map("n", "<leader>sq", "<cmd>wq<cr>")
