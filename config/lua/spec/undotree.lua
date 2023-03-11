return {
    'mbbill/undotree',
    config = function()
        require("which-key").register({
            u = { vim.cmd.UndotreeToggle, "Undo Tree" },
        }, { prefix = "<leader>" })
    end,
}
