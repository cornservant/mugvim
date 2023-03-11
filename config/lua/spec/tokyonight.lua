return {
    'folke/tokyonight.nvim',
    config = function()
        require("tokyonight").setup {
            style = "moon",
        }
    end,
}
