return {
    'echasnovski/mini.nvim',
    version = '*',
    lazy = false,
    config = function()
        require('mini.surround').setup({
            n_lines = 999,
        })
        require('mini.move').setup({})
        require('mini.files').setup({})
    end,
    keys = {
        { "<leader>e", function() require("mini.files").open() end, desc = "Mini Files" },
    },
}
