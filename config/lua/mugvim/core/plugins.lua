local M = {}

local fs = require("mugvim.fs")

function M.install_packer()
    local install_path = fs.join_paths(vim.fn.stdpath("data"), "site", "pack", "packer", "start", "packer.nvim")
    if vim.fn.isdirectory(install_path) == 0 then
        vim.fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
        vim.cmd [[packadd packer.nvim]]
        return true
    else
        return false
    end
end

function M.init()
    local fresh_install = M.install_packer()

    require("packer").startup(function(use)
        use 'wbthomason/packer.nvim'

        use 'folke/tokyonight.nvim'
        use 'rose-pine/neovim'
        use 'sainnhe/everforest'
        use 'cocopon/iceberg.vim'
        use 'arcticicestudio/nord-vim'
        use 'catppuccin/vim'
        use 'morhetz/gruvbox'
        use 'navarasu/onedark.nvim'

        use 'tpope/vim-surround'
        use 'tpope/vim-repeat'
        use 'NoahTheDuke/vim-just'
        use 'junegunn/vim-peekaboo'
        use 'theprimeagen/harpoon'
        use 'editorconfig/editorconfig-vim'

        use {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
        }

        use {
            'folke/which-key.nvim',
            config = function()
                require("which-key").setup {
                }
            end,
        }

        use {
            'nvim-lualine/lualine.nvim',
            requires = {
                'nvim-tree/nvim-web-devicons',
            },
        }

        use {
            "simrat39/symbols-outline.nvim",
            config = function()
                require('symbols-outline').setup()
            end
        }

        use {
            "nvim-tree/nvim-tree.lua",
            requires = {
                'nvim-tree/nvim-web-devicons', -- optional, for file icons
            },
            config = function()
                require('nvim-tree').setup({
                    renderer = {
                        highlight_git = true,
                    },
                })
            end,
        }

        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
        }

        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup()
            end,
        }

        use {
            'akinsho/bufferline.nvim',
            config = function()
                require('bufferline').setup()
            end,
        }

        use {
            'mbbill/undotree'
        }

        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup({
                })
            end,
        }

        use {
            'startup-nvim/startup.nvim',
            requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
            config = function()
                require("startup").setup()
            end,
        }

        use {
            'TimUntersberger/neogit',
            requires = { 'nvim-lua/plenary.nvim' },
        }

        use {
            "tpope/vim-fugitive",
            cmd = {
                "G",
                "Git",
                "Gdiffsplit",
                "Gread",
                "Gwrite",
                "Ggrep",
                "GMove",
                "GDelete",
                "GBrowse",
                "GRemove",
                "GRename",
                "Glgrep",
                "Gedit"
            },
            ft = { "fugitive" }
        }

        use {
            'VonHeikemen/lsp-zero.nvim',
            requires = {
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
            }
        }

    end)

    if fresh_install then
        require("packer").sync()
    end
end

return M
