return {
    'folke/which-key.nvim',
    config = function()
        require('which-key').register({
            b = {
                name = "Buffer"
            },
            f = {
                name = "File"
            },
            g = {
                name = "Git",
            },
            s = {
                name = "Search",
            },
            t = {
                name = "Telescope",
                h = {
                    name = "History",
                },
            },
            ['+'] = {
                name = "Mugvim",
                -- c = { M.edit_userconfig, 'Edit User Configuration' },
                l = { function() require('lazy').home() end, 'Lazy' },
            },
            c = { vim.cmd.bdelete, 'Close Buffer' },
            w = { vim.cmd.write, 'Write' },
            q = { vim.cmd.quit, 'Quit' },
        }, { prefix = '<leader>' })
    end,
}
