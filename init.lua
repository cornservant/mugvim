-- nvim-tree recommendation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- VERSION CHECK
if vim.fn.has "nvim-0.8" ~= 1 then
    vim.notify("Please upgrade your Neovim base installation. Mugvim requires v0.8+", vim.log.levels.WARN)
    vim.wait(5000)
    vim.cmd "cquit"
end

-- BOOSTRAP
local base_dir = vim.env.MUGVIM_BASE_DIR
    or (function()
        local init_path = debug.getinfo(1, "S").source
        return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
    end)()

local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"
local config_dir = base_dir .. path_sep .. "config"

if not vim.tbl_contains(vim.opt.rtp:get(), config_dir) then
    vim.opt.rtp:prepend(config_dir)
end

require("mugvim"):init(base_dir)
