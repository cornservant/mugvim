require("which-key").register({
    q = { vim.cmd.quit, "Quit" },
    w = { vim.cmd.write, "Write" },
}, { prefix = "<leader>" })

