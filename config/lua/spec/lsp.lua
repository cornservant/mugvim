return {
    {
        "ErichDonGubler/lsp_lines.nvim",
        config = function()
            vim.diagnostic.config({ virtual_text = false })
            require("lsp_lines").setup()
        end,
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        lazy = false,
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'saadparwaiz1/cmp_luasnip' },

            -- Snippets
            -- { 'L3MON4D3/LuaSnip' },
            -- { 'rafamadriz/friendly-snippets' },

            -- LSP lines
            { 'ErichDonGubler/lsp_lines.nvim' },
        },
        config = function()
            local lsp = require('lsp-zero').preset({
                set_sources = 'recommended',
            })

            lsp.ensure_installed({
                'tsserver',
                'eslint',
                'rust_analyzer',
                'jdtls',
            })

            lsp.set_sign_icons({
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = '»',
            })

            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({buffer = bufnr})

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

                require('which-key').register({
                    l = {
                        name = 'LSP',
                        a = { vim.lsp.buf.code_action, "Code Action" },
                        w = { vim.lsp.buf.workspace_symbol, "Workspace Symbols" },
                        d = { vim.diagnostic.open_float, "Diagnostic" },
                        R = { vim.lsp.buf.references, "References" },
                        r = { vim.lsp.buf.rename, "Rename" },
                        f = { vim.lsp.buf.format, "Format" },
                        l = { require("lsp_lines").toggle, "Toggle lsp_lines" },
                    },
                }, { prefix = '<leader>', buffer = bufnr })
            end)

            lsp.setup()

            local cmp = require('cmp')

            cmp.setup({
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({select = false}),
                }
            })

            vim.diagnostic.config({
                virtual_text = true,
            })
        end,
    }
}
