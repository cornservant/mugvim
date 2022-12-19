local M = {}

function M.setup()
    local nt = require('nvim-tree')

    nt.setup({
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
        e = { function() nt.toggle(true) end, "Tree" },
    }, { prefix = "<leader>" })
end

return M
