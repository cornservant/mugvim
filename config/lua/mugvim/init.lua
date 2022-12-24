local M = {}

function M:init(base_dir)
    require('mugvim.bootstrap'):init(base_dir)
    require('mugvim.config').setup()
    require('mugvim.remap').setup() -- should run before plugin config due to setting the map leader
    require('mugvim.plugins').setup()

    return self
end

return M
