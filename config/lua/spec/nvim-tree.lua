local icons = require("lvim.icons")

return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
        require('nvim-tree').setup({
            update_cwd = true,
            update_focused_file = {
                enable = true,
                update_cwd = true,
            },
            git = {
                enable = true,
                ignore = false,
                timeout = 200,
            },
            diagnostics = {
                enable = true,
                show_on_dirs = false,
            },
            renderer = {
                indent_markers = {
                    enable = false,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        none = " ",
                    },
                },
                icons = {
                    webdev_colors = true,
                    show = {
                        git = true,
                        folder = true,
                        file = true,
                        folder_arrow = true,
                    },
                },
                highlight_git = true,
                group_empty = false,
                root_folder_modifier = ":t",
            },
            view = {
                side = "left",
                width = 60,
                adaptive_size = true,
            },
            trash = {
                cmd = "trash",
                require_confirm = true,
            },
        })

        require("which-key").register({
            e = { function() require("nvim-tree.api").tree.toggle() end, "Tree" },
        }, { prefix = "<leader>" })
    end,
}
