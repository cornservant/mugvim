return {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            },
        })
    end,
    delete_to_trash = true,
    keys = {
        { "<leader>e",  function() require("oil").open() end,                          desc = "File Browser" },
        { "<leader>ft", function() require("oil.actions").toggle_trash.callback() end, desc = "Browse Trash" },
    },
}
