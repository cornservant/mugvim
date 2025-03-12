return {
    "exit91/rfc.nvim",
    lazy = false,
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "vim-scripts/rfc-syntax",
    },
    config = function()
        require("telescope").load_extension("rfc")
    end,
    keys = {
        { "<leader>sr", function() require('telescope').extensions.rfc.rfc() end, desc = 'RFC Browser' },
    },
}
