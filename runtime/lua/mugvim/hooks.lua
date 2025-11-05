local M = {}

local hooks = {
    after_plugin_load = {},
}

local extra_plugins = {}

--@param plugins @LazySpec
function M.set_extra_plugins(plugins)
    extra_plugins = plugins
end

function M.get_extra_plugins()
    return extra_plugins
end

---@param action fun()
function M.after_plugin_load(action)
    hooks.after_plugin_load[#hooks.after_plugin_load + 1] = action
end

function M.run_after_plugin_load_hooks()
    for _, action in ipairs(hooks.after_plugin_load) do
        action()
    end
end

return M
