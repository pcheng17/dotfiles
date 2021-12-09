local cmp = require('cmp')

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
    },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- local servers = { 'clangd' }

-- for _, lsp in ipairs(servers) do
--     require('lspconfig')[lsp].setup {
--         capabilities = capabilities
--     }
-- end
