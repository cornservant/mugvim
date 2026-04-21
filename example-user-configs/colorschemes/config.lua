vim.pack.add({
    'https://github.com/GustavoPrietoP/doom-themes.nvim',
    'https://github.com/EdenEast/nightfox.nvim',
    { src = 'https://github.com/catppuccin/nvim', name = "catppuccin" },
    'https://github.com/navarasu/onedark.nvim',
    'https://github.com/Tsuzat/NeoSolarized.nvim',
    'https://github.com/sainnhe/everforest',
})


-- onedark
--
require("onedark").setup({ style = "darker" })

-- NeoSolarized
--
require('NeoSolarized').setup({ style = "light", transparent = false, })

-- everforest
--
-- options: "hard", "medium", "soft"
vim.g.everforest_background = "soft"
-- options: 0, 1
vim.g.everforest_enable_italic = 1
-- options: 0, 1, 2
vim.g.everforest_transparent_background = 1
