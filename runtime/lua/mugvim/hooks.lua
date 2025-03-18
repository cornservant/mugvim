local M = {}

local hooks = {
    after_plugin_load = {},
}

---@param action fun()
function M.after_plugin_load(action)
    hooks.after_plugin_load[#hooks.after_plugin_load+1] = action
end

function M.run_after_plugin_load_hooks()
    for _, action in ipairs(hooks.after_plugin_load) do
        action()
    end
end

return M
