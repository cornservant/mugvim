return {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
        })
    end,
    keys = {
        { "<leader>e", function() require("oil").open() end, desc = "File Browser" },
    },
}
