return {
    'hedyhli/outline.nvim',
    config = function()
        require('outline').setup()
    end,
    keys = {
        { "<leader>o", function() require 'outline'.open() end, desc = "Open Outline" }
    },
}
