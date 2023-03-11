return {
    'folke/which-key.nvim',
    config = function()
        require('which-key').register({
            c = { vim.cmd.bdelete, 'Close Buffer' },
            w = { vim.cmd.write, 'Write' },
            q = { vim.cmd.quit, 'Quit' },
                ['+'] = {
                name = "Mugvim",
                -- c = { M.edit_userconfig, 'Edit User Configuration' },
                l = { function() require('lazy').home() end, 'Lazy' },
            }
        }, { prefix = '<leader>' })
    end,
}
