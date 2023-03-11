return {
    'VonHeikemen/lsp-zero.nvim',
    lazy = false,
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        local lsp = require('lsp-zero')
        local wk = require('which-key')

        wk.register({
            l = {
                name = "LSP",
                ["="] = { name = "Format" }
            }
        }, { prefix = "<leader>" })


        lsp.preset('recommended')
        lsp.ensure_installed({
            'tsserver',
            'eslint',
            'rust_analyzer',
            'jdtls',
        })


        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        })

        -- disable completion with tab
        -- this helps with copilot setup
        cmp_mappings['<Tab>'] = nil
        cmp_mappings['<S-Tab>'] = nil

        lsp.setup_nvim_cmp({
            mapping = cmp_mappings
        })

        lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = 'E',
                warn = 'W',
                hint = 'H',
                info = 'I'
            }
        })

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            if client.name == "eslint" then
                vim.cmd.LspStop('eslint')
                return
            end

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

            wk.register({
                l = {
                    name = 'LSP',
                    a = { vim.lsp.buf.code_action, "Code Action" },
                    w = { vim.lsp.buf.workspace_symbol, "Workspace Symbols" },
                    d = { vim.diagnostic.open_float, "Diagnostic" },
                    R = { vim.lsp.buf.references, "References" },
                    r = { vim.lsp.buf.rename, "Rename" },
                    f = { vim.lsp.buf.format, "Format" },
                },
            }, { prefix = '<leader>', buffer = bufnr })

        end)

        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true,
        })
    end,
}
