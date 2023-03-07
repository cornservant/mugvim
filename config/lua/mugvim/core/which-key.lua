local M = {}

local fs = require('mugvim.fs')
local paths = require('mugvim.bootstrap')
local wk = require('which-key')
local userconfig = fs.join_paths(paths.config_dir, 'after', 'plugin', 'userconfig.lua')

function M.edit_userconfig()
    vim.cmd.edit(userconfig)
end

function M.setup()
    wk.register({
        c = { vim.cmd.bdelete, 'Close Buffer' },
        w = { vim.cmd.write, 'Write' },
        q = { vim.cmd.quit, 'Quit' },
        ['+'] = {
            name = "Mugvim",
            c = { M.edit_userconfig, 'Edit User Configuration' },
            l = { function() require('lazy').home() end, 'Lazy' },
        }
    }, { prefix = '<leader>' })
end

return M
