return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
        -- "nvim-telescope/telescope-dap.nvim",
        -- "mfussenegger/nvim-dap-python",
        -- "jbyuki/one-small-step-for-vimkind",
        -- "Pocco81/DAPInstall.nvim",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup()

        dap.adapters.codelldb = {
            type = 'server',
            port = "${port}",
            executable = {
                -- You can install codelldb via Mason or manually
                command = vim.fn.stdpath("data") .. '/mason/packages/codelldb/extension/adapter/codelldb',
                -- Or if installed via Homebrew
                -- command = '/opt/homebrew/opt/codelldb/libexec/extension/adapter/codelldb',
                args = { "--port", "${port}" }
            }
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
            }
        }

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { noremap = true, desc = "Toggle breakpoint" })
        vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { noremap = true, desc = "Run to cursor" })
        vim.keymap.set("n", "<leader>dr", dap.continue, { noremap = true, desc = "Continue" })

        vim.keymap.set("n", "<leader>?", function()
            require("dapui").eval(nil, { enter = true })
        end)

        vim.keymap.set("n", "<F1>", dap.continue)
        vim.keymap.set("n", "<F2>", dap.step_into)
        vim.keymap.set("n", "<F3>", dap.step_over)
        vim.keymap.set("n", "<F4>", dap.step_out)
        vim.keymap.set("n", "<F6>", dap.step_back)
        vim.keymap.set("n", "<F12>", dap.restart)

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end
}
