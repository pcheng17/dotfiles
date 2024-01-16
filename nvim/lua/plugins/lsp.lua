local root_files = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac', -- AutoTools
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        { "j-hui/fidget.nvim", opts = {} }
    },
    config = function()
        require("mason").setup({})

        -- TODO Figure out what this capabilities thing is...
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local lspconfig = require("lspconfig")

        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "cmake",
                "lua_ls",
                "pyright",
            },
            handlers = {
                function(server_name) -- default handler
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,

                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "exepath", "vim" }
                                }
                            }
                        },
                    })
                end,

                ["clangd"] = function()
                    require("lspconfig").clangd.setup({
                        capabilities = capabilities,
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--header-insertion=iwyu",
                            "--offset-encoding=utf-16"
                        },
                        root_dir = function(fname)
                            return
                                lspconfig.util.root_pattern(table.unpack(root_files))(fname) or
                                lspconfig.util.find_git_ancestor(fname)
                        end,
                    })
                end,

                ["pyright"] = function()
                    require("lspconfig").pyright.setup({
                        capabilities = capabilities,
                        before_init = function(_, config)
                            local function get_python_path(workspace)
                                local util = require('lspconfig/util')
                                local path = util.path

                                -- Use activated virtualenv.
                                if vim.env.VIRTUAL_ENV then
                                    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
                                end

                                -- Find and use virtualenv in workspace directory.
                                for _, pattern in ipairs({'*', '.*'}) do
                                    local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
                                    if match ~= '' then
                                        return path.join(path.dirname(match), 'bin', 'python')
                                    end
                                end

                                -- Fallback to system Python.
                                return exepath('python3') or exepath('python') or 'python'
                            end

                            config.settings.python.pythonPath = get_python_path(config.root_dir)
                            print("Using Python interpreter: " .. config.settings.python.pythonPath)
                        end,
                    })
                end
            }
        })

        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<Tab>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                    { name = 'cmdline' }
                })
        })

        -- TODO Do I need this?
        -- vim.diagnostic.config({
        --     virtual_text = true,
        -- })

    end
}
