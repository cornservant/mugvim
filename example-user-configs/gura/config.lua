require("mugvim.colors").setup("tokyonight")

vim.cmd(":TransparentEnable")
vim.o.cursorline = false
vim.diagnostic.config({ virtual_lines = false })
vim.g.indent_blankline_enabled = false

vim.g.mugvim_snippets = "~/git.loporrit.de/mugvim-snippets"
vim.g.mugvim_autoformat = false
vim.g.mugvim_obsidian_workspaces = {
    {
        name = "personal",
        path = "~/git.loporrit.de/obsidian-vault",
    },
    {
        name = "kehrwasser",
        path = "~/git.loporrit.de/kehrwasser-vault",
    },
}
