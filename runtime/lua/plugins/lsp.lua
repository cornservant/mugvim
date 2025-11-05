return {
    {
        'folke/lazydev.nvim',
        cond = false, -- I don't use this 99.99% of the time
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            vim.diagnostic.config({
                virtual_text = false,
                virtual_lines = {
                    only_current_line = true,
                },
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require 'treesitter-context'.setup {
                enable = false,
            }
        end,
        keys = {
            { "<leader>tc", function() require 'treesitter-context'.toggle() end, desc = "Toggle treesitter context" },
        }
    },
}
