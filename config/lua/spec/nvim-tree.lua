return {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
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
    end,
    keys = {
        { "<leader>ft", function() require("nvim-tree.api").tree.toggle({ update_root = true }) end, desc = "Tree" },
    },
}
