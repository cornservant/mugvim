local M = {
    mugvim_path = nil,
    runtime_path = nil,
}

local conf = require("mugvim.conf")
local util = require("mugvim.util")

function M:version()
    local version_file = M.mugvim_path .. "/VERSION"
    local version = vim.fn.readfile(version_file)[1]
    return version
end

function M:user_config_path()
    return vim.fn.stdpath("config") .. "/config.lua"
end

function M:edit_user_config()
    vim.cmd.edit(M:user_config_path())
end

function M:init(mugvim_path, runtime_path)
    M.mugvim_path = mugvim_path
    M.runtime_path = runtime_path

    conf:fix_bufferline_colors()
    conf:load_user_config()

    conf:base_options()
    conf:base_keymaps()
    conf:base_autocmds()
    conf:base_lsp()
    conf:base_commands()

    conf:plugin_which_key()
    require("bufferline").setup({})
    conf:plugin_bufferline_editor();
    conf:plugin_luasnip()
    conf:plugin_blink_cmp()
    conf:plugin_gitsigns()
    conf:plugin_lualine()
    conf:plugin_neogit()
    conf:plugin_todo_comments()
    conf:plugin_outline()
    conf:plugin_undotree()
    conf:plugin_treesitter_context()
    conf:plugin_snacks()
    require("tokyonight").setup({ style = "moon" })
    require("trouble").setup({})
    conf:plugin_lsp_lines()
    util:load_on_ft("plugin:package-info", { "json" }, function()
        require("package-info").setup({})
    end)
    util:load_on_ft("plugin:crates", { "rust", "toml" }, function()
        require("crates").setup({})
    end)
    conf:plugin_multicursor()
    conf:plugin_obsidian()
    conf:plugin_oil()
    -- FIXME: keybinds
    -- conf:plugin_vim_table_mode()

    require('mugvim.hooks').run_after_plugin_load_hooks()
end

return M
