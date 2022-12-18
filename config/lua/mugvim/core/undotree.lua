local M = {}

function M.setup()
    require("which-key").register({
        u = { vim.cmd.UndotreeToggle, "Undo Tree" },
    }, { prefix = "<leader>" })
end

return M
