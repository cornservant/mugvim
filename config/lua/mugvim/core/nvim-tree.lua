local M = {}

local icons = require("lvim.icons")

function M.setup()
    local nt = require('nvim-tree')

    nt.setup({
        ignore_ft_on_setup = {
            "dashboard",
        },
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
            icons = {
                hint = icons.diagnostics.BoldHint,
                info = icons.diagnostics.BoldInformation,
                warning = icons.diagnostics.BoldWarning,
                error = icons.diagnostics.BoldError,
            },
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
                glyphs = {
                    default = icons.ui.Text,
                    symlink = icons.ui.FileSymlink,
                    git = {
                        deleted = icons.git.FileDeleted,
                        ignored = icons.git.FileIgnored,
                        renamed = icons.git.FileRenamed,
                        staged = icons.git.FileStaged,
                        unmerged = icons.git.FileUnmerged,
                        unstaged = icons.git.FileUnstaged,
                        untracked = icons.git.FileUntracked,
                    },
                    folder = {
                        default = icons.ui.Folder,
                        empty = icons.ui.EmptyFolder,
                        empty_open = icons.ui.EmptyFolderOpen,
                        open = icons.ui.FolderOpen,
                        symlink = icons.ui.FolderSymlink,
                    },
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
        e = { function() nt.toggle(true) end, "Tree" },
    }, { prefix = "<leader>" })
end

return M
