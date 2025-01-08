function setup_lsp_if_binary_exists(lsp, opts)
    local lspconfig = require('lspconfig')
    local entry = lspconfig[lsp]
    local command = entry.document_config.default_config.cmd[1]
    if vim.fn.executable(command) == 1 then
        -- print("LSP     found: " .. command)
        entry.setup(opts)
    else
        -- print("    not found: " .. command)
    end
end

function setup_markdown_oxide(on_attach)
    if vim.fn.executable("markdown-oxide") == 1 then
        -- An example nvim-lspconfig capabilities setting
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
        -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
        capabilities.workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        }

        require("lspconfig").markdown_oxide.setup({
            capabilities = capabilities,
        })
    end
end

return {
    {
        'folke/neodev.nvim'
    },
    {
        'williamboman/mason.nvim'
    },
    {
        'williamboman/mason-lspconfig.nvim'
    },
    {
        'nvim-lua/lsp-status.nvim'
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            vim.diagnostic.config({ virtual_text = false })
            require("lsp_lines").setup()
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            -- Set up nvim-cmp.
            local cmp = require 'cmp'

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
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
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
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
            require('mason').setup()
            require('mason-lspconfig').setup()
            require('neodev').setup()

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- setup_lsp_if_binary_exists('eslint', {
            --     capabilities = capabilities,
            -- })

            setup_lsp_if_binary_exists('ts_ls', {
                capabilities = capabilities,
            })

            -- setup_lsp_if_binary_exists('tailwindcss', {
            --     capabilities = capabilities,
            -- })

            setup_lsp_if_binary_exists('rust_analyzer', {
                capabilities = capabilities,
            })

            setup_lsp_if_binary_exists('ocamllsp', {
                capabilities = capabilities,
            })

            setup_lsp_if_binary_exists('lua_ls', {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        }
                    }
                },
            })
            --
            -- setup_lsp_if_binary_exists('jdtls', {
            --     capabilities = capabilities,
            -- })

            setup_lsp_if_binary_exists('nixd', {
                capabilities = capabilities,
            })

            -- setup_lsp_if_binary_exists('typst_lsp', {
            --     capabilities = capabilities,
            -- })
            --
            -- setup_lsp_if_binary_exists('ruff_lsp', {
            --     capabilities = capabilities,
            -- })
            --
            -- setup_lsp_if_binary_exists('bashls', {
            --     capabilities = capabilities,
            -- })
            --
            -- setup_lsp_if_binary_exists('erlangls', {
            --     capabilities = capabilities,
            -- })
            --
            -- setup_lsp_if_binary_exists('kotlin_language_server', {
            --     capabilities = capabilities,
            -- })
            --
            -- setup_lsp_if_binary_exists('nginx_language_server', {
            --     capabilities = capabilities,
            -- })
            --
            -- setup_lsp_if_binary_exists('ocamllsp', {
            --     capabilities = capabilities,
            -- })
            setup_markdown_oxide()

            setup_lsp_if_binary_exists('zls', {
                capabilities = capabilities,
            })

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

                    require('which-key').add({
                        { "<leader>l",  buffer = ev.buf,                                    group = "LSP" },
                        { "<leader>lR", vim.lsp.buf.references,                             buffer = ev.buf, desc = "References" },
                        { "<leader>la", vim.lsp.buf.code_action,                            buffer = ev.buf, desc = "Code Action" },
                        { "<leader>ld", vim.diagnostic.open_float,                          buffer = ev.buf, desc = "Diagnostic" },
                        { "<leader>lf", function() vim.lsp.buf.format { async = true } end, buffer = ev.buf, desc = "Format" },
                        { "<leader>ll", require("lsp_lines").toggle,                        buffer = ev.buf, desc = "Toggle lsp_lines" },
                        { "<leader>lr", vim.lsp.buf.rename,                                 buffer = ev.buf, desc = "Rename" },
                        { "<leader>lw", vim.lsp.buf.workspace_symbol,                       buffer = ev.buf, desc = "Workspace Symbols" },
                    })
                end,
            })

            vim.diagnostic.config({
                virtual_text = true,
            })
        end
    },
}
