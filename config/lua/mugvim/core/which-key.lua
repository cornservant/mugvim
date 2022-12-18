local M = {}

function M.setup()
    require("which-key").register({
        c = { vim.cmd.bdelete, "Close Buffer" },
        w = { vim.cmd.write, "Write" },
        q = { vim.cmd.quit, "Quit" },
    }, { prefix = "<leader>" })
end

return M
