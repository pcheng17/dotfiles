local custom_prompt = [[ You are an AI programming assistant. Please keep your answers

You must:
- Follow the user's requirements carefully and to the letter.
- Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
- Minimize other prose.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return relevant code.

When asked vim/neovim questions never use vimscript, always suggest neovim lua
]]

return {
    {
        "olimorris/codecompanion.nvim",
        enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
            "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
            -- {
            --     "stevearc/dressing.nvim", -- Optional: Improves `vim.ui.select`
            --     opts = {},
            -- },
        },
        config = function()
            local cc = require("codecompanion")

            local cfg = {
                strategies = {
                    chat = {
                        adapter = "anthropic",
                    },
                },
                opts = {
                    system_prompt = custom_prompt,
                },
                display = {
                    chat = {
                        window = {
                            width = 0.40,
                        },
                    },
                },
            }
            cc.setup(cfg)

            -- create a folder to store our chats
            local Path = require("plenary.path")
            local data_path = vim.fn.stdpath("data")
            local save_folder = Path:new(data_path, "codecompanion")
            if not save_folder:exists() then
                save_folder:mkdir({ parents = true })
            end

            -- fzf-lua for our saved chats
            vim.api.nvim_create_user_command("CodeCompanionLoad", function()
                local fzf = require("fzf-lua")
                local cwd = save_folder:absolute()

                -- Configure the custom actions
                local actions = {
                    -- Load the selected file
                    ["default"] = function(selected)
                        if selected and selected[1] then
                            -- Strip icon and create absolute path
                            local absolute_path = vim.fn.resolve(cwd .. "/" .. selected[1])
                            vim.cmd("edit " .. vim.fn.fnameescape(absolute_path))
                        end
                    end,
                    -- Delete the selected file with confirmation
                    ["ctrl-d"] = function(selected)
                        if selected and selected[1] then
                            -- Strip icon and create absolute path
                            local absolute_path = vim.fn.resolve(cwd .. "/" .. selected[1])
                            local display_name = vim.fn.fnamemodify(absolute_path, ":t")

                            local choice = vim.fn.confirm(
                                "Delete " .. display_name .. "?",
                                "&Yes\n&No",
                                2
                            )
                            if choice == 1 then
                                vim.fn.delete(absolute_path)
                                vim.notify("Deleted " .. display_name, vim.log.levels.INFO)
                                -- Trigger a refresh by returning true
                                return true
                            end
                        end
                    end
                }

                -- Call fzf with proper configuration
                fzf.files({
                    prompt = "CodeCompanion Chats > ",
                    cwd = cwd,
                    actions = actions,
                    header = "Actions: <enter>: open | <c-d>: delete",
                    winopts = {
                        height = 0.95,
                        width = 0.90,
                        preview = {
                            hidden = "nohidden",
                            layout = "vertical",
                        },
                    },
                    file_icons = false,
                    git_icons = false,
                })
            end, {})

            -- save current chat, `CodeCompanionSave foo bar baz` will save as 'foo-bar-baz.md'
            vim.api.nvim_create_user_command("CodeCompanionSave", function(opts)
                local success, chat = pcall(function()
                    return cc.buf_get_chat(0)
                end)
                if not success or chat == nil then
                    vim.notify(
                        "CodeCompanionSave should only be called from CodeCompanion chat buffers",
                        vim.log.levels.ERROR
                    )
                    return
                end
                if #opts.fargs == 0 then
                    vim.notify("CodeCompanionSave requires at least 1 arg to make a file name", vim.log.levels.ERROR)
                else
                    local save_name = table.concat(opts.fargs, "-") .. ".md"
                    local save_path = Path:new(save_folder, save_name)
                    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                    save_path:write(table.concat(lines, "\n"), "w")
                    vim.notify("Chat saved to " .. save_path:absolute(), vim.log.levels.INFO)
                end
            end, { nargs = "*" })

            vim.keymap.set("n", "<leader>gpt",
                function()
                    cc.toggle()

                    vim.cmd("wincmd L")
                    vim.cmd(
                        "vertical resize " .. math.floor(vim.o.columns * cfg.display.chat.window.width)
                    )

                    local current_buffer = vim.api.nvim_get_current_buf()
                    local buffer_name = vim.api.nvim_buf_get_name(current_buffer)
                    if string.find(buffer_name, "%[CodeCompanion%]") then
                        vim.cmd("set filetype=markdown")
                    end
                end, {
                    silent = true,
                    desc = "Chat[GPT] window",
                }
            )

            vim.keymap.set("n", "<leader>cl", ":CodeCompanionLoad<CR>", {
                silent = true,
                desc = "Load CodeCompanion Chat",
            })

            -- Expand 'cc' into 'CodeCompanion' in the command line
            vim.cmd([[cab cc CodeCompanion]])
        end
    }
}
