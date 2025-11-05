require("mugvim.hooks").set_extra_plugins({
    'GustavoPrietoP/doom-themes.nvim',
    'EdenEast/nightfox.nvim',
    { 'catppuccin/nvim', name = 'catppuccin' },
    {
        'navarasu/onedark.nvim',
        config = function()
            require("onedark").setup({
                style = "darker"
            })
        end,
    },
    {
        'Tsuzat/NeoSolarized.nvim',
        config = function()
            require('NeoSolarized').setup({
                style = "light",
                transparent = false,
            })
        end,
    },
    {
        'sainnhe/everforest',
        config = function()
            -- > everforest
            -- options: "hard", "medium", "soft"
            vim.g.everforest_background = "soft"
            -- options: 0, 1
            vim.g.everforest_enable_italic = 1
            -- options: 0, 1, 2
            vim.g.everforest_transparent_background = 1
        end,
    },
})
