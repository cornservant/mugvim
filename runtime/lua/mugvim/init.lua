local M = {
    _version = nil,
}

local conf = require("mugvim.conf")
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

    conf:fix_bufferline_colors()
    conf:load_user_config()

    conf:base_options()
    conf:base_keymaps()
    conf:base_autocmds()
    conf:base_lsp()
    conf:base_commands()

    conf:plugin_which_key()
    conf:plugin_nvim_tree_sitter()
    require("bufferline").setup({})
    conf:plugin_bufferline_editor();
    require("cloak").setup({})
    require("Comment").setup({})
    conf:plugin_luasnip()
    conf:plugin_blink_cmp()
    conf:plugin_gitsigns()
    conf:plugin_lualine()
    conf:plugin_neogit()
    conf:plugin_todo_comments()
    conf:plugin_undotree()
    conf:plugin_treesitter_context()
    conf:plugin_snacks()
    require("tokyonight").setup({ style = "moon" })
    require("trouble").setup({})
    conf:plugin_lsp_lines()
    conf:plugin_multicursor()
    conf:plugin_obsidian()
    conf:plugin_oil()
    conf:plugin_vim_table_mode()
    conf:plugin_outline()
    conf:plugin_mini()
    conf:plugin_fff()
    conf:plugin_haunt()

    require('mugvim.hooks').run_after_plugin_load_hooks()
end

return M
