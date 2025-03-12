local M = {}

function M.setup(color)
    M.color = color or "tokyonight"
end

function M.apply()
    vim.cmd.colorscheme(M.color)
end

return M
