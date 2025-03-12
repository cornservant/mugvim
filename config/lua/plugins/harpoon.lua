return {
    'theprimeagen/harpoon',
    branch = "harpoon2",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require("harpoon"):setup({})
    end,
    keys = {
        { "<leader>a", function() require('harpoon'):list():add() end, desc = "Harpoon Add" },
        {
            "<C-e>",
            function()
                require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
            end,
            desc = "Harpoon List"
        }
    }
}
