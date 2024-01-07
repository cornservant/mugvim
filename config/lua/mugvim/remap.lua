local M = {}

function M.setup()
    vim.g.mapleader = ' '

    vim.keymap.set('i', '<C-c>', '<Esc>')

    vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
    vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
    vim.keymap.set('n', '<leader>k', '<cmd>cnext<CR>zz')
    vim.keymap.set('n', '<leader>j', '<cmd>cprev<CR>zz')

    vim.keymap.set('n', '<S-h>', '<cmd>bprev<cr>')
    vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>')
    vim.keymap.set('n', '<C-h>', '<cmd>wincmd h<cr>')
    vim.keymap.set('n', '<C-j>', '<cmd>wincmd j<cr>')
    vim.keymap.set('n', '<C-k>', '<cmd>wincmd k<cr>')
    vim.keymap.set('n', '<C-l>', '<cmd>wincmd l<cr>')
end

return M
