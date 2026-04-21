local M = {}

function M:load_on_ft(name, ft_pattern, callback)
    local once_group = vim.api.nvim_create_augroup("once-" .. name, { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = ft_pattern,
        group = once_group,
        callback = callback,
    })
end

return M
