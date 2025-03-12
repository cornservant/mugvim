local M = {}

function M.setup()
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
end

return M
