local M = {}

function M.setup()
    local ui = require("harpoon.ui")
    local mark = require("harpoon.mark")

    require("which-key").register({
        a = { "<cmd>lua require(\"harpoon.mark\").add_file()<cr>", "Harpoon Mark" },
    }, { prefix = "<leader>" })

    vim.keymap.set("n", "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end)
end

return M
