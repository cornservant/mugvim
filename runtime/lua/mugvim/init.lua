local M = {}

function M:load_user_config()
    local user_config_path = vim.fn.stdpath("config") .. "/config.lua";
    pcall(dofile, user_config_path)
end

function M:init(runtime_path)
    require('mugvim.config').setup()
    require('mugvim.remap').setup()   -- should run before plugin config due to setting the map leader
    require('mugvim.lazy').setup()
    vim.opt.rtp:prepend(runtime_path) -- `lazy` fucks up the runtime path, so we fix it here
    M:load_user_config()
end

return M
