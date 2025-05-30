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
    keys = {
        { "<leader>gG", vim.cmd.Git, desc = "Fugitive" }
    }
}
