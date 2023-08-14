local M = {}

local banner = {
    "",
    "",
    "  /\\_/\\  ",
    " ( o.o ) ",
    "  > ^ <  ",
    "",
    "マッグヴィム",
    "",
    "in Gedenken an",
    "Bram Moolenaar",
    "",
    "",
}

local fs = require('mugvim.fs')
local paths = require('mugvim.bootstrap')
local userconfig = fs.join_paths(paths.config_dir, 'after', 'plugin', 'userconfig.lua')

function M.edit_userconfig()
    vim.cmd.edit(userconfig)
end

return {
    'glepnir/dashboard-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'doom',

            config = {
                header = banner,
                center = {
                    {
                        icon = '󰝒  ',
                        desc = 'New Buffer             ',
                        action = function() vim.cmd('enew') end,
                        key = 'n',
                    },
                    {
                        icon = '󱋡  ',
                        desc = 'Recent Files           ',
                        action = require 'telescope.builtin'.oldfiles,
                        key = 'r',
                    },
                    {
                        icon = '󰈞  ',
                        desc = 'Find Files             ',
                        action = require 'telescope.builtin'.find_files,
                        key = 'f',
                    },
                    {
                        icon = '󰈲  ',
                        desc = 'Grep Files             ',
                        action = require 'telescope.builtin'.find_files,
                        key = '/',
                    },
                    {
                        icon = '󰊢  ',
                        desc = 'Git Status             ',
                        action = require 'telescope.builtin'.git_status,
                        key = 's',
                    },
                    {
                        icon = '󰒓  ',
                        desc = 'Edit User Configuration',
                        action = M.edit_userconfig,
                        key = 'e',
                    },
                    {
                        icon = '󰗶  ',
                        desc = 'Check Health           ',
                        action = function() vim.cmd("checkhealth") end,
                        key = 'h',
                    },
                },
            }
        }
    end,
}
