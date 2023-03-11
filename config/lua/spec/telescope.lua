return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require 'telescope.builtin'

        require('which-key').register({
            b = {
                name = 'Buffer',
                b = { builtin.buffers, 'Buffers' },
            },
            f = {
                name = 'File',
                g = { builtin.git_files, 'Git Files' },
                r = { builtin.oldfiles, 'Recent Files' },
                f = { builtin.find_files, 'Files' },
            },
            g = {
                name = 'Git',
                t = {
                    name = 'Telescope',
                    b = { builtin.git_branches, 'Branches' },
                    c = { builtin.git_commits, 'Commits' },
                    s = { builtin.git_status, 'Status' },
                    S = { builtin.git_stash, 'Stash' },
                },
            },
            s = {
                name = 'Search',
                b = { builtin.current_buffer_fuzzy_find, 'Search in Buffer' },
                t = { builtin.live_grep, 'Live Grep' },
                v = { builtin.treesitter, 'Treesitter' },
            },
            t = {
                name = 'Telescope',
                b = { builtin.builtin, 'Builtins' },
                m = { builtin.marks, 'Marks' },
                j = { builtin.jumplist, 'Jumplist' },
                r = { builtin.registers, 'Registers' },
                h = {
                    name = "History",
                    c = { builtin.search_history, "Command History" },
                    s = { builtin.search_history, "Search History" },
                    q = { builtin.quickfixhistory, "Quickfix History" },
                },
            },
            ["+"] = {
                c = { builtin.commands, 'Commands' },
                s = { builtin.colorscheme, 'Colorschemes' },
                k = { builtin.keymaps, 'Keymaps' },
            }
        }, { prefix = '<leader>' })
    end,
}
