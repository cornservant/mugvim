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

        use "tpope/vim-surround"
        use "tpope/vim-repeat"
        use "NoahTheDuke/vim-just"
        use "theprimeagen/harpoon"


        use {
            'folke/which-key.nvim',
            config = function()
                require("which-key").setup {
                }
            end,
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
                    view = {
                        float = {
                            enable = true,
                            open_win_config = {
                                width = vim.api.nvim_list_uis()[1].width,
                                height = vim.api.nvim_list_uis()[1].height,
                            },
                        },
                    }
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
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup({
                })
            end,
        }

        use {
            "nvim-telescope/telescope.nvim"
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

    end)

    if fresh_install then
        require("packer").sync()
    end
end

return M
