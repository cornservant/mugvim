return {
    {
        'nvim-lua/lsp-status.nvim'
    },
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
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            -- Set up nvim-cmp.
            local cmp = require 'cmp'

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
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
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                }, {
                    { name = 'buffer' },
                })
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local lspconfig = require('lspconfig')

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            lspconfig.eslint.setup {
                capabilities = capabilities,
            }

            lspconfig.tsserver.setup {
                capabilities = capabilities,
            }

            lspconfig.tailwindcss.setup {
                capabilities = capabilities,
            }

            lspconfig.rust_analyzer.setup {
                capabilities = capabilities,
            }

            lspconfig.lua_ls.setup {
                capabilities = capabilities,
            }

            lspconfig.jdtls.setup {
                capabilities = capabilities,
            }

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local opts = { buffer = ev.buf, remap = false }

                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "[e", function()
                        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
                    end, opts)
                    vim.keymap.set("n", "]e", function()
                        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
                    end, opts)
                    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

                    require('which-key').register({
                        l = {
                            name = 'LSP',
                            a = { vim.lsp.buf.code_action, "Code Action" },
                            w = { vim.lsp.buf.workspace_symbol, "Workspace Symbols" },
                            d = { vim.diagnostic.open_float, "Diagnostic" },
                            R = { vim.lsp.buf.references, "References" },
                            r = { vim.lsp.buf.rename, "Rename" },
                            f = { function() vim.lsp.buf.format { async = true } end, "Format" },
                            l = { require("lsp_lines").toggle, "Toggle lsp_lines" },
                        },
                    }, { prefix = '<leader>', buffer = ev.buf })
                end,
            })

            local cmp = require('cmp')

            cmp.setup({
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                }
            })

            vim.diagnostic.config({
                virtual_text = true,
            })
        end
    },
}
