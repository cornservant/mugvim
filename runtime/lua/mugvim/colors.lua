local M = {}

function M.setup(color)
    color = color or "tokyonight"
    vim.cmd.colorscheme(color)
end

return M
