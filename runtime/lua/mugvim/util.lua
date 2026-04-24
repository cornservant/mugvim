local M = {}

function M:load_on_ft(name, ft_pattern, callback)
    local once_group = vim.api.nvim_create_augroup("once-" .. name, { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = ft_pattern,
        group = once_group,
        callback = callback,
    })
end

function M:measure_time_ms(action)
    local start = vim.uv.hrtime()
    action()
    return (vim.uv.hrtime() - start) / 1e6
end

function M:measure_and_print(name, action)
    local duration_ms = M:measure_time_ms(action)
    print(string.format("%s: %.4f ms", name, duration_ms))
end

return M
