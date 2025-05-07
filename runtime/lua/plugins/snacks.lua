local default_header = [[


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
        bufdelete = { enabled = true },
        dashboard = {
            enabled = true,
            width = 32,
            pane_gap = 2,
            preset = {
                header = vim.g.mugvim_banner or default_header,
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
                        icon = '󰗶  ',
                        desc = 'Check Health           ',
                        action = function() vim.cmd("checkhealth") end,
                        key = 'h',
                    },
                    {
                        icon = '  ',
                        desc = 'Edit Config            ',
                        action = function() vim.cmd.edit(require("mugvim.init"):user_config_path()) end,
                        key = 'c',
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
        image = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
    },
}
