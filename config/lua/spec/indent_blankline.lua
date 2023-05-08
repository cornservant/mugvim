return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require("indent_blankline").setup({
            show_current_context = false,
            show_current_context_start = false,
        })

        local list = vim.g.indent_blankline_filetype_exclude
        table.insert(list, "dashboard")
        vim.g.indent_blankline_filetype_exclude = list
    end,
}
