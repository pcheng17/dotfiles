return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {
        "Trouble",
        "TroubleToggle"
    },
    keys = {
        "<leader>tt",
        "<leader>tn",
        "<leader>tp"
    },
    config = function()
        local trouble = require("trouble")
        trouble.setup({})

        local function nmap(keys, func, desc)
            vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
        end

        nmap("<leader>tt", function() trouble.toggle() end, "Trouble toggle")
        nmap("<leader>tn", function() trouble.next({ skip_groups = true, jump = true }) end, "Trouble next")
        nmap("<leader>tp", function() trouble.previous({ skip_groups = true, jump = true }) end, "Trouble previous")
    end
}
