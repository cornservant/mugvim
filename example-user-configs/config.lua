require("mugvim.colors").setup("tokyonight")

vim.g.mugvim_autoformat = true

-- TODO: make this a configuration flag
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "help",
        "startuptime",
        "qf",
        "lspinfo",
        "man",
        "checkhealth"
    },
    command = [[
    nnoremap <buffer><silent> q :close<CR>
    set nobuflisted
]],
})
