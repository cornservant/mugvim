return {
    'dhruvasagar/vim-table-mode',
    init = function()
        vim.g.table_mode_disable_mappings = 1
        vim.g.table_mode_disable_tableize_mappings = 1
        require("which-key").add({
            { "<localleader>f", group = "Formula" },
        })
    end,
    keys = {
        { "<localleader>t",    function() vim.cmd("TableModeToggle") end,                                    ft = "markdown", desc = "Toggle table mode" },

        { "<localleader>x",    function() vim.call("tablemode#spreadsheet#DeleteColumn") end,                ft = "markdown", desc = "Delete column" },

        { "<localleader>i",    function() vim.call("tablemode#spreadsheet#InsertColumn", 0) end,             ft = "markdown", desc = "Insert column before" },
        { "<localleader>a",    function() vim.call("tablemode#spreadsheet#InsertColumn", 1) end,             ft = "markdown", desc = "Insert column after" },

        { "<localleader>h",    function() vim.call("tablemode#spreadsheet#cell#Motion", "h") end,            ft = "markdown", desc = "Motion left" },
        { "<localleader>j",    function() vim.call("tablemode#spreadsheet#cell#Motion", "j") end,            ft = "markdown", desc = "Motion down" },
        { "<localleader>k",    function() vim.call("tablemode#spreadsheet#cell#Motion", "k") end,            ft = "markdown", desc = "Motion up" },
        { "<localleader>l",    function() vim.call("tablemode#spreadsheet#cell#Motion", "l") end,            ft = "markdown", desc = "Motion right" },

        { "<localleader>?",    function() vim.call("tablemode#spreadsheet#EchoCell") end,                    ft = "markdown", desc = "Echo cell" },
        { "<localleader>s",    function() vim.call("tablemode#spreadsheet#Sort", "") end,                    ft = "markdown", desc = "Sort" },

        { "<localleader>f",    function() vim.call("tablemode#spreadsheet#formula#Add") end,                 ft = "markdown", desc = "Add" },
        { "<localleader><cr>", function() vim.call("tablemode#spreadsheet#formula#EvaluateFormulaLine") end, ft = "markdown", desc = "Evaluate formula line" },

        { "<localleader>=",    function() vim.call("tablemode#table#Realign", ".") end,                      ft = "markdown", desc = "Realign" },
    },
}
