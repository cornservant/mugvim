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
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require('lspconfig')

            lspconfig.eslint.setup {
            }

            lspconfig.tsserver.setup {
            }

            lspconfig.tailwindcss.setup {
            }

            lspconfig.rust_analyzer.setup {
            }

            lspconfig.lua_ls.setup {
            }

            lspconfig.jdtls.setup {
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
                    ['<CR>'] = cmp.mapping.confirm({select = false}),
                }
            })

            vim.diagnostic.config({
                virtual_text = true,
            })
        end
    },
}
