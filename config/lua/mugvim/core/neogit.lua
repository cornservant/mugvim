local M = {}

function M.setup()
    local neogit = require('neogit')

    neogit.setup({
    })

    require("which-key").register({
        g = {
            name = "Git",
            g = { neogit.open, "Neogit" }
        },
    }, { prefix = "<leader>" })
end

return M
