local M = {}

function M.setup(color)
    M.color = color
end

function M.apply()
    vim.cmd.colorscheme(M.color or "tokyonight")
end

return M
