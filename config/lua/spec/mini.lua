return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        require('mini.surround').setup({
            n_lines = 999,
        })
        require('mini.move').setup({})
    end,
}
