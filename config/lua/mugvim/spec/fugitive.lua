return {
    'tpope/vim-fugitive',
    cmd = {
        'G',
        'Git',
        'Gdiffsplit',
        'Gread',
        'Gwrite',
        'Ggrep',
        'GMove',
        'GDelete',
        'GBrowse',
        'GRemove',
        'GRename',
        'Glgrep',
        'Gedit'
    },
    ft = { 'fugitive' },
    config = function()
        vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
    end,
}
