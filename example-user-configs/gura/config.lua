vim.o.cursorline = false
vim.diagnostic.config({ virtual_lines = false })
vim.g.indent_blankline_enabled = false

vim.g.mugvim_transparent = true
vim.g.mugvim_snippets = "~/git.loporrit.de/mugvim-snippets"
vim.g.mugvim_autoformat = false
vim.g.mugvim_obsidian_workspaces = {
    {
        name = "personal",
        path = "~/git.loporrit.de/obsidian-vault",
    },
}

require("mugvim.hooks").after_plugin_load(function()
    vim.cmd.colorscheme("tokyonight")
end)

vim.lsp.enable({
    'bashls',
    'clangd',
    'eslint',
    'jdtls',
    'lua_ls',
    'markdown_oxide',
    'nixd',
    'ocamllsp',
    'pyright',
    'ruff_lsp',
    'rust_analyzer',
    'tinymist',
    'ts_ls',
    'zls',
    'html',
    'cssls',
})
