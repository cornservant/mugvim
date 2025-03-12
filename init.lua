local runtime_path = vim.env.MUGVIM_BASE_DIR .. "/config"
if not vim.tbl_contains(vim.opt.rtp:get(), runtime_path) then
    vim.opt.rtp:prepend(runtime_path)
end
require("mugvim"):init(runtime_path)
