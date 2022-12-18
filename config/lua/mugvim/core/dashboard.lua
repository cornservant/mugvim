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

function M.setup()
    local dashboard = require('dashboard')

    dashboard.custom_center = {
        { icon = '  ',
            desc = 'New Buffer                              ',
            action = vim.cmd.new,
            shortcut = ':new' },
        { icon = '  ',
            desc = 'Edit User Configuration                 ',
            action = require('mugvim.core.which-key').edit_userconfig,
            shortcut = 'SPC + c' },
    }

    dashboard.custom_header = mugvim_banner;
end

return M
