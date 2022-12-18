local M = {}

function M.setup()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
end

return M
