require("mugvim.colors").colors("tokyonight")
-- vim.cmd(":TransparentDisable")


vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    group = vim.api.nvim_create_augroup("lsp_format_on_save", {}),
    callback = function()
        vim.lsp.buf.format()
    end,
})

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
