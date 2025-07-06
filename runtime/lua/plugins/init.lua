return {
    'folke/lazy.nvim',
    'folke/neodev.nvim',
    { 'rose-pine/neovim', name = 'rose-pine' },
    { 'catppuccin/nvim',  name = 'catppuccin' },
    {
        'Tsuzat/NeoSolarized.nvim',
        config = function()
            require('NeoSolarized').setup({
                style = "light",
                transparent = false,
            })
        end,
    },
    'EdenEast/nightfox.nvim',
    'GustavoPrietoP/doom-themes.nvim',
    'eddyekofo94/gruvbox-flat.nvim',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'NoahTheDuke/vim-just',
    'junegunn/vim-peekaboo',
    'editorconfig/editorconfig-vim',
    'LunarVim/bigfile.nvim',
    'xiyaowong/transparent.nvim',
    'dhruvasagar/vim-table-mode',
}
