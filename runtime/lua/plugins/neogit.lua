return {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('neogit').setup({})
    end,
    keys = {
        { "<leader>gg", function() require('neogit').open() end, desc = "Neogit" },
    },
}
