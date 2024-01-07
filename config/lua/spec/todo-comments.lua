return {
    'folke/todo-comments.nvim',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require("todo-comments").setup({})
    end,
    keys = {
        {"[t", function() require("todo-comments").jump_next() end,  desc = "Next todo comment"},
        {"]t", function() require("todo-comments").jump_prev() end,  desc = "Previous todo comment"},
    }
}
