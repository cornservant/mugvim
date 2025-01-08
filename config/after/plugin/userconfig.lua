-- local themes = { "catppuccin-mocha", "tokyonight-moon", "rose-pine-moon", "doom-ayu-mirage" }
-- local randomTheme = themes[math.random(1, #themes)]
require("mugvim.colors").colors("tokyonight-moon")
vim.cmd(":TransparentEnable")
vim.o.cursorline = false
vim.diagnostic.config({ virtual_lines = false })
vim.g.indent_blankline_enabled = false


vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = "*.adoc",
    group = vim.api.nvim_create_augroup("asciidoc_to_html", { clear = true }),
    callback = function(ctx)
        local cmd = "silent !asciidoctor " .. ctx.file
        vim.cmd(cmd)
    end,
})

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
--
-- vim.api.nvim_create_autocmd({ "VimLeave" }, {
--     pattern = "home.nix",
--     group = vim.api.nvim_create_augroup("home-manager", { clear = true }),
--     callback = function(ctx)
--         local cmd = "!env NIXPKGS_ALLOW_UNFREE=1 home-manager switch"
--         vim.cmd(cmd)
--     end,
-- })
