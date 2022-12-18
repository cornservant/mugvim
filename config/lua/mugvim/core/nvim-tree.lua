local M = {}

function M.setup()
    local nvim_tree = require('nvim-tree')

    nvim_tree.setup({
        renderer = {
            highlight_git = true,
        },
        view = {
            side = "left",
            width = 60,
            adaptive_size = true,
        },
    })

    require("which-key").register({
        e = { nvim_tree.toggle, "Tree" },
    }, { prefix = "<leader>" })
end

return M
