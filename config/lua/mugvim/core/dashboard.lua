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
    local home = os.getenv('HOME')

    dashboard.custom_center = {
        { icon = '  ',
            desc = 'Recently latest session                  ',
            shortcut = 'SPC s l',
            action = 'SessionLoad' },
        { icon = '  ',
            desc = 'Recently opened files                   ',
            action = 'DashboardFindHistory',
            shortcut = 'SPC f h' },
        { icon = '  ',
            desc = 'Find  File                              ',
            action = 'Telescope find_files find_command=rg,--hidden,--files',
            shortcut = 'SPC f f' },
        { icon = '  ',
            desc = 'File Browser                            ',
            action = 'Telescope file_browser',
            shortcut = 'SPC f b' },
        { icon = '  ',
            desc = 'Find  word                              ',
            action = 'Telescope live_grep',
            shortcut = 'SPC f w' },
        { icon = '  ',
            desc = 'Open Personal dotfiles                  ',
            action = 'Telescope dotfiles path=' .. home .. '/.dotfiles',
            shortcut = 'SPC f d' },
    }

    dashboard.custom_header = mugvim_banner;
end

return M
