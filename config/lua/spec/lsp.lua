return {
    {
        "ErichDonGubler/lsp_lines.nvim",
        config = function()
            vim.diagnostic.config({ virtual_text = false })
            require("lsp_lines").setup()
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-vsnip',
        },
        config = function()
              -- Set up nvim-cmp.
              local cmp = require'cmp'

              cmp.setup({
                  snippet = {
                      -- REQUIRED - you must specify a snippet engine
                      expand = function(args)
                          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                          -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                      end,
                  },
                  window = {
                      -- completion = cmp.config.window.bordered(),
                      -- documentation = cmp.config.window.bordered(),
                  },
                  mapping = cmp.mapping.preset.insert({
                      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                      ['<C-f>'] = cmp.mapping.scroll_docs(4),
                      ['<C-Space>'] = cmp.mapping.complete(),
                      ['<C-e>'] = cmp.mapping.abort(),
                      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                  }),
                  sources = cmp.config.sources({
                      { name = 'nvim_lsp' },
                      { name = 'vsnip' }, -- For vsnip users.
                      -- { name = 'luasnip' }, -- For luasnip users.
                      -- { name = 'ultisnips' }, -- For ultisnips users.
                      -- { name = 'snippy' }, -- For snippy users.
                  }, {
                      { name = 'buffer' },
                  })
              })
        end
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
