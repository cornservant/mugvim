return {
    {
        'akinsho/bufferline.nvim',
        opts = {},
    },
    {
        'https://git.loporrit.de/long/bufferline-editor.nvim',
        dependencies = { 'akinsho/bufferline.nvim' },
        opts = {},
        keys = {
            { "<c-e>", function() require("bufferline-editor").editor_toggle() end, desc = "Edit Buffers" },
            { "<leader>be", function() require("bufferline-editor").editor_toggle() end, desc = "Edit Buffers" },
        }
    },
}
