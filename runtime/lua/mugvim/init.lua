local M = {}

function M:load_user_config()
    local user_config_path = vim.fn.stdpath("config") .. "/config.lua";
    if vim.fn.filereadable(user_config_path) == 1 then
        local ok, _ = pcall(dofile, user_config_path)
        if not ok then
            vim.notify("error in user config " .. user_config_path, vim.log.levels.ERROR)
        end
    end
end

function M:after_lazy()
    vim.opt.rtp:prepend(M.runtime_path) -- `lazy` fucks up the runtime path, so we fix it here
    require('mugvim.autocommands').setup()
    require('mugvim.colors').apply() -- apply colorscheme specified in the user config
    if vim.g.mugvim_transparent then
        vim.cmd(":TransparentEnable")
    end
end

function M:init(runtime_path)
    M.runtime_path = runtime_path
    M:load_user_config()
    require('mugvim.config').setup()
    require('mugvim.remap').setup() -- should run before `lazy` due to setting the map leader
    require('mugvim.lazy').setup()
    M:after_lazy()
end

return M
