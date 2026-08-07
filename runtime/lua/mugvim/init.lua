local M = {
    _version = nil,
}

local setup = require("mugvim.setup")
local util = require("mugvim.util")

function M:version()
    return M._version
end

function M:user_config_path()
    return vim.fn.stdpath("config") .. "/config.lua"
end

function M:edit_user_config()
    vim.cmd.edit(M:user_config_path())
end

function M:init(version)
    M._version = version

    setup:fix_bufferline_colors()
    setup:load_user_config()

    setup:base_options()
    setup:base_keymaps()
    setup:base_autocmds()
    setup:base_lsp()
    setup:base_commands()

    setup:plugin_which_key()
    setup:plugin_nvim_treesitter()
    require("bufferline").setup({})
    setup:plugin_bufferline_editor();
    require("cloak").setup({})
    require("Comment").setup({})
    setup:plugin_luasnip()
    setup:plugin_blink_cmp()
    setup:plugin_gitsigns()
    setup:plugin_lualine()
    setup:plugin_neogit()
    setup:plugin_todo_comments()
    setup:plugin_undotree()
    setup:plugin_treesitter_context()
    setup:plugin_snacks()
    require("tokyonight").setup({ style = "moon" })
    require("trouble").setup({})
    setup:plugin_lsp_lines()
    setup:plugin_multicursor()
    setup:plugin_obsidian()
    setup:plugin_oil()
    setup:plugin_vim_table_mode()
    setup:plugin_outline()
    setup:plugin_mini()
    setup:plugin_fff()
    setup:plugin_haunt()

    require('mugvim.hooks').run_after_plugin_load_hooks()
end

return M
