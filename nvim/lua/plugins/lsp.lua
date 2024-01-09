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
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require("lspconfig")

        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "cmake",
                "lua_ls",
            },
            handlers = {
                function(server_name) -- default handler
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,

                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        },
                    }
                end,

                ["clangd"] = function()
                    require("lspconfig").clangd.setup {
                        capabilities = capabilities,
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--header-insertion=iwyu",
                            "--suggest-missing-includes",
                        },
                        root_dir = function(fname)
                            return
                                lspconfig.util.root_pattern(unpack(root_files))(fname) or
                                lspconfig.util.find_git_ancestor(fname)
                        end,
                    }
                end,
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
                ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        -- TODO Do I need this?
        -- vim.diagnostic.config({
        --     virtual_text = true,
        -- })

    end
}
