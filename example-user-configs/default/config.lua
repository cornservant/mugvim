vim.g.mugvim_autoformat = false

require("mugvim.hooks").after_plugin_load(function()
    vim.cmd.colorscheme("tokyonight")
end)
