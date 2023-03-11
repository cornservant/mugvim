local M = {}

local mugvim_banner = {
    "",
    "",
    "888b     d888                  888     888 8888888 888b     d888",
    "8888b   d8888                  888     888   888   8888b   d8888",
    "88888b.d88888                  888     888   888   88888b.d88888",
    "888Y88888P888 888  888  .d88b. Y88b   d88P   888   888Y88888P888",
    "888 Y888P 888 888  888 d88P\"88b Y88b d88P    888   888 Y888P 888",
    "888  Y8P  888 888  888 888  888  Y88o88P     888   888  Y8P  888",
    "888   \"   888 Y88b 888 Y88b 888   Y888P      888   888   \"   888",
    "888       888  \"Y88888  \"Y88888    Y8P     8888888 888       888",
    "                            888                                 ",
    "                       Y8b d88P                                 ",
    "                        \"Y88P\"                                  ",
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
                header = mugvim_banner,

                center = {
                    {
                        icon = '  ',
                        desc = 'New Buffer                              ',
                        action = function() vim.cmd('enew') end,
                        shortcut = ':DashboardNewFile'
                    },
                    {
                        icon = '󱦺  ',
                        desc = 'Recent Files                            ',
                        action = require('telescope.builtin').oldfiles,
                        shortcut = ':Telescope oldfiles'
                    },
                    {
                        icon = '  ',
                        desc = 'Edit User Configuration                 ',
                        action = M.edit_userconfig,
                        shortcut = 'SPC + c          '
                    },
                },
            }
        }
    end,
}
