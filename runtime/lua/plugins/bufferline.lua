return {
    {
        'akinsho/bufferline.nvim',
        opts = {},
    },
    {
        'https://git.loporrit.de/long/bufferline-editor.nvim',
        dependencies = { 'akinsho/bufferline.nvim' },
        ---@type bufferline-editor.config
        opts = {
            max_width = 80,
            max_height = 24,
        },
        keys = {
            { "<c-e>", function() require("bufferline-editor").editor_toggle() end, desc = "Edit Buffers" },
            { "<leader>be", function() require("bufferline-editor").editor_toggle() end, desc = "Edit Buffers" },
        }
    },
}
