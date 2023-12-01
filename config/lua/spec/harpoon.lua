return {
    'theprimeagen/harpoon',
    branch = "harpoon2",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require("harpoon")

        require("which-key").register({
            a = { function() harpoon:list():append() end, "Harpoon Append" },
        }, { prefix = "<leader>" })

        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    end,
}
