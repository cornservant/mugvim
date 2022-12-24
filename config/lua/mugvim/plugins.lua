local M = {}

local fs = require('mugvim.fs')

function M.install_lazy()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    vim.opt.runtimepath:prepend(lazypath)
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--single-branch",
            "https://github.com/folke/lazy.nvim.git",
            lazypath,
        })
        return true
    end
    return false
end

function M.setup()
    M.install_lazy()

    local opts = {}

    local plugins = {
        'folke/lazy.nvim',
        {
            'folke/which-key.nvim',
            config = function()
                require('mugvim.core.which-key').setup()
            end,
        },
        'folke/neodev.nvim',

        {
            'folke/tokyonight.nvim',
            config = function()
                require('mugvim.core.tokyonight').setup()
            end,
        },
        'rose-pine/neovim',
        {
            'sainnhe/everforest',
            config = function()
                require('mugvim.core.everforest').setup()
            end,
        },
        'cocopon/iceberg.vim',
        'arcticicestudio/nord-vim',
        'catppuccin/vim',
        'morhetz/gruvbox',
        {
            'navarasu/onedark.nvim',
            config = function()
                require('mugvim.core.onedark').setup()
            end,
        },

        'tpope/vim-surround',
        'tpope/vim-repeat',
        'NoahTheDuke/vim-just',
        'junegunn/vim-peekaboo',
        {
            'theprimeagen/harpoon',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('mugvim.core.harpoon').setup()
            end,
        },
        'editorconfig/editorconfig-vim',
        {
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('mugvim.core.indent_blankline').setup()
            end,
        },

        {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('mugvim.core.telescope').setup()
            end,
        },


        {
            'nvim-lualine/lualine.nvim',
            dependencies = {
                'nvim-tree/nvim-web-devicons',
            },
            config = function()
                require('mugvim.core.lualine').setup()
            end,
        },

        {
            'simrat39/symbols-outline.nvim',
            config = function()
                require('mugvim.core.symbols-outline').setup()
            end,
        },

        {
            'nvim-tree/nvim-tree.lua',
            dependencies = {
                'nvim-tree/nvim-web-devicons', -- optional, for file icons
            },
            config = function()
                require('mugvim.core.nvim-tree').setup()
            end,
        },

        {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
            config = function()
                require('mugvim.core.treesitter').setup()
            end,
        },

        {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('mugvim.core.gitsigns').setup()
            end,
        },

        {
            'akinsho/bufferline.nvim',
            config = function()
                require('mugvim.core.bufferline').setup()
            end,
        },

        {
            'mbbill/undotree',
            config = function()
                require('mugvim.core.undotree').setup()
            end,
        },

        {
            'numToStr/Comment.nvim',
            config = function()
                require('mugvim.core.comment').setup()
            end,
        },

        {
            'glepnir/dashboard-nvim',
            config = function()
                require('mugvim.core.dashboard').setup()
            end,
        },

        {
            'TimUntersberger/neogit',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('mugvim.core.neogit').setup()
            end,
        },

        {
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
        },

        {
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
                require('mugvim.core.lsp').setup()
            end,
        }
    }

    require('lazy').setup(plugins, opts)
end

return M
