return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require("ibl").setup({
            enabled = true,
            exclude = {
                filetypes = {
                    "dashboard",
                    "lspinfo",
                    "checkhealth",
                    "help",
                    "man",
                    "gitcommit",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "",
                },
            },
        })
    end,
}
