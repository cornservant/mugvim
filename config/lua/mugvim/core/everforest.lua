local M = {}

function M.setup()
    -- > everforest
    -- options: "hard", "medium", "soft"
    vim.g.everforest_background = "soft"
    -- options: 0, 1
    vim.g.everforest_enable_italic = 1
    -- options: 0, 1, 2
    vim.g.everforest_transparent_background = 1
end

return M
