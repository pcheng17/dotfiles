return {
    "stevearc/overseer.nvim",
    config = function()
        require("overseer").setup({
            task_list = {
                bindings = {
                    -- Disable defaults
                    ["<C-l>"] = false,
                    ["<C-h>"] = false,
                    -- Add my own
                    ["<Tab>"] = "IncreaseDetail",
                    ["<S-Tab>"] = "DecreaseDetail",
                }
            }
        })

        vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>", { silent = true, desc = "Overseer Run" })
        vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle!left<cr>", { silent = true, desc = "Overseer Toggle bottom" })
    end
}
