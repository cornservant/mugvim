local M = {}

local fs = require "mugvim.fs"

local initialized = false;

-- _G.require_clean = require("mugvim.utils.modules").require_clean
-- _G.require_safe = require("mugvim.utils.modules").require_safe
-- _G.reload = require("mugvim.utils.modules").reload

---Initialize the `&runtimepath` variables and prepare for startup
---@return table
function M:init(base_dir)
    if initialized then
        print "MugVim: already initialized!"
        return self
    else
        initialized = true
    end

    -- SETUP PATHS

    vim.fn.stdpath = function(name)
        if name == "cache" then
            return fs.join_paths(base_dir, "cache")
        elseif name == "config" then
            return fs.join_paths(base_dir, "config")
        elseif name == "config_dirs" then
            vim.call("stdpath", name)
        elseif name == "data" then
            return fs.join_paths(base_dir, "data")
        elseif name == "data_dirs" then
            vim.call("stdpath", name)
        elseif name == "log" then
            return fs.join_paths(base_dir, "log")
        elseif name == "run" then
            vim.call("stdpath", name)
        elseif name == "state" then
            return fs.join_paths(base_dir, "state")
        else
            print("MugVim: unknown stdpath argument " .. name)
        end
    end

    self.base_dir = base_dir
    self.runtime_dir = vim.fn.stdpath("data")
    self.config_dir = vim.fn.stdpath("config")
    self.cache_dir = vim.fn.stdpath("cache")
    self.pack_dir = fs.join_paths(self.runtime_dir, "site", "pack")
    self.packer_install_dir = fs.join_paths(self.runtime_dir, "site", "pack", "packer", "start", "packer.nvim")
    self.packer_cache_path = fs.join_paths(self.config_dir, "plugin", "packer_compiled.lua")

    vim.opt.rtp:remove(fs.join_paths(vim.call("stdpath", "data"), "site"))
    vim.opt.rtp:remove(fs.join_paths(vim.call("stdpath", "data"), "site", "after"))
    vim.opt.rtp:prepend(fs.join_paths(self.runtime_dir, "site"))
    vim.opt.rtp:append(fs.join_paths(self.runtime_dir, "mugvim", "after"))
    vim.opt.rtp:append(fs.join_paths(self.runtime_dir, "site", "after"))

    vim.opt.rtp:remove(vim.call("stdpath", "config"))
    vim.opt.rtp:remove(fs.join_paths(vim.call("stdpath", "config"), "after"))
    vim.opt.rtp:prepend(self.config_dir)
    vim.opt.rtp:append(fs.join_paths(self.config_dir, "after"))

    vim.cmd [[let &packpath = &runtimepath]]

    -- SETUP PLUGINS

    require("mugvim.config")
    require("mugvim.remap")
    require("mugvim.colors")
    require("mugvim.core.plugins").init()

    -- require("mugvim.config"):init()

    -- require("mugvim.plugin-loader").init {
    --     package_root = self.pack_dir,
    --     install_path = self.packer_install_dir,
    -- }

    -- require("mugvim.core.mason").bootstrap()

    return self
end

---Update LunarVim
---pulls the latest changes from github and, resets the startup cache
-- function M:update()
--     require("mugvim.core.log"):info "Trying to update LunarVim..."

--     vim.schedule(function()
--         reload("mugvim.utils.hooks").run_pre_update()
--         local ret = reload("mugvim.utils.git").update_base_mugvim()
--         if ret then
--             reload("mugvim.utils.hooks").run_post_update()
--         end
--     end)
-- end

return M
