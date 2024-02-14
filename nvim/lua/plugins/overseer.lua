return {
    "stevearc/overseer.nvim",
    enabled = false,
    cmd = { "OverseerOpen", "OverseerRun", "OverseerInfo", "OverseerToggle" },
    keys = { "<leader>or", "<leader>ot" },
    config = function()
        require("overseer").setup({
            task_list = {
                bindings = {
                    -- Add my own
                    ["<Tab>"] = "IncreaseDetail",
                    ["<S-Tab>"] = "DecreaseDetail",
                    ["j"] = "ScrollOutputDown",
                    ["k"] = "ScrollOutputUp"
                }
            }
        })

        vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>", { silent = true, desc = "Overseer Run" })
        vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle!left<cr>", { silent = true, desc = "Overseer Toggle bottom" })
    end
}
