return {
    'TimUntersberger/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local neogit = require('neogit')

        neogit.setup({
        })

        require("which-key").register({
            g = {
                name = "Git",
                g = { neogit.open, "Neogit" }
            },
        }, { prefix = "<leader>" })
    end,
}
