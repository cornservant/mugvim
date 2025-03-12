require("mugvim.colors").setup("tokyonight")

vim.cmd(":TransparentEnable")
vim.o.cursorline = false
vim.diagnostic.config({ virtual_lines = false })
vim.g.indent_blankline_enabled = false
vim.g.mugvim_autoformat = false
