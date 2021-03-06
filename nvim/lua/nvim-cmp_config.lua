local cmp = require('cmp')

cmp.setup {
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'buffer' },
    },
}

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- local servers = { 'clangd' }

-- for _, lsp in ipairs(servers) do
--     require('lspconfig')[lsp].setup {
--         capabilities = capabilities
--     }
-- end
