local M = {}

local fs = require('mugvim.fs')

function M.install_packer()
    local install_path = fs.join_paths(vim.fn.stdpath('data'), 'site', 'pack', 'packer', 'start', 'packer.nvim')
    if vim.fn.isdirectory(install_path) == 0 then
        vim.fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
        vim.cmd [[packadd packer.nvim]]
        return true
    else
        return false
    end
end

function M.setup()
    local fresh_install = M.install_packer()

    require('packer').startup(function(use)
        use 'wbthomason/packer.nvim'

        use {
            'folke/tokyonight.nvim',
            config = function()
                require('mugvim.core.tokyonight').setup()
            end,
        }
        use 'rose-pine/neovim'
        use {
            'sainnhe/everforest',
            config = function()
                require('mugvim.core.everforest').setup()
            end,
        }
        use 'cocopon/iceberg.vim'
        use 'arcticicestudio/nord-vim'
        use 'catppuccin/vim'
        use 'morhetz/gruvbox'
        use {
            'navarasu/onedark.nvim',
            config = function()
                require('mugvim.core.onedark').setup()
            end,
        }

        use 'tpope/vim-surround'
        use 'tpope/vim-repeat'
        use 'NoahTheDuke/vim-just'
        use 'junegunn/vim-peekaboo'
        use {
            'theprimeagen/harpoon',
            config = function()
                require('mugvim.core.harpoon').setup()
            end,
        }
        use 'editorconfig/editorconfig-vim'
        use {
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('mugvim.core.indent_blankline').setup()
            end,
        }

        use {
            'folke/which-key.nvim',
            config = function()
                require('mugvim.core.which-key').setup()
            end,
        }

        use {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            config = function()
                require('mugvim.core.telescope').setup()
            end,
        }


        use {
            'nvim-lualine/lualine.nvim',
            requires = {
                'nvim-tree/nvim-web-devicons',
            },
            config = function()
                require('mugvim.core.lualine').setup()
            end,
        }

        use {
            'simrat39/symbols-outline.nvim',
            config = function()
                require('symbols-outline').setup()
            end,
        }

        use {
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons', -- optional, for file icons
            },
            config = function()
                require('mugvim.core.nvim-tree').setup()
            end,
        }

        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
            config = function()
                require('mugvim.core.treesitter').setup()
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
            'mbbill/undotree',
            config = function()
                require('mugvim.core.undotree').setup()
            end,
        }

        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup({
                })
            end,
        }

        -- use {
        --     'startup-nvim/startup.nvim',
        --     requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        -- }
        use {
            'glepnir/dashboard-nvim',
            config = function()
                require('mugvim.core.dashboard').setup()
            end,
        }

        use {
            'TimUntersberger/neogit',
            requires = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('mugvim.core.neogit').setup()
            end,
        }

        use {
            'tpope/vim-fugitive',
            cmd = {
                'G',
                'Git',
                'Gdiffsplit',
                'Gread',
                'Gwrite',
                'Ggrep',
                'GMove',
                'GDelete',
                'GBrowse',
                'GRemove',
                'GRename',
                'Glgrep',
                'Gedit'
            },
            ft = { 'fugitive' },
            config = function()
                require('mugvim.core.fugitive').setup()
            end,
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
            },
            config = function()
                require('mugvim.core.lsp').setup()
            end,
        }

    end)

    if fresh_install then
        require('packer').sync()
    end
end

return M
