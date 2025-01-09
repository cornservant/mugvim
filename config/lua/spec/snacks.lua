local fs = require('mugvim.fs')
local paths = require('mugvim.bootstrap')
local userconfig = fs.join_paths(paths.config_dir, 'after', 'plugin', 'userconfig.lua')

local function edit_userconfig()
    vim.cmd.edit(userconfig)
end

local custom_header = [[


  /\_/\
 ( o.o )
  > ^ <

マッグヴィム

in Gedenken an
Bram Moolenaar]]


return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            width = 32,
            pane_gap = 2,
            preset = {
                header = custom_header,
                keys = {
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
                        action = require 'telescope.builtin'.live_grep,
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
                        action = edit_userconfig,
                        key = 'e',
                    },
                    {
                        icon = '󰗶  ',
                        desc = 'Check Health           ',
                        action = function() vim.cmd("checkhealth") end,
                        key = 'h',
                    },
                },
            },
            sections = {
                { section = "header" },
                { section = "keys",   gap = 0, padding = 2 },
                { section = "startup" },
            },
        },
        indent = {
            enabled = true,
            animate = { enabled = false },
        },
        notifier = { enabled = true },
        quickfile = { enabled = true },
    },
}
