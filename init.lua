local mugvim_path = vim.env.MUGVIM_BASE_DIR
local runtime_path = mugvim_path .. "/runtime"
vim.opt.rtp:prepend(runtime_path)
vim.opt.packpath:prepend(mugvim_path)
require("mugvim"):init(mugvim_path, runtime_path)
