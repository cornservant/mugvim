return {
    'folke/which-key.nvim',
    config = function()
        require('which-key').add({
            { "<leader>+",  group = "Mugvim" },
            { "<leader>+l", function() require('lazy').home() end, desc = "Lazy" },
            { "<leader>b",  group = "Buffer" },
            { "<leader>c",  vim.cmd.bdelete,                       desc = "Close Buffer" },
            { "<leader>f",  group = "File" },
            { "<leader>g",  group = "Git" },
            { "<leader>q",  vim.cmd.quit,                          desc = "Quit" },
            { "<leader>s",  group = "Search" },
            { "<leader>t",  group = "Telescope" },
            { "<leader>th", group = "History" },
            { "<leader>w",  vim.cmd.write,                         desc = "Write" },
        })
    end,
}
