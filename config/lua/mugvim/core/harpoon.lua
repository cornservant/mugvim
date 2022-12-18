local M = {}

function M.setup()
    local ui = require("harpoon.ui")
    local mark = require("harpoon.mark")

    require("which-key").register({
        a = { mark.add_file, "Harpoon Mark" },
    }, { prefix = "<leader>" })

    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
end

return M
