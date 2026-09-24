local M = {
    _version = nil,
}

local setup = require("mugvim.setup")
local util = require("mugvim.util")
local b = require("mugvim.b")

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

    b:bench("fix_bufferline_colors", setup.fix_bufferline_colors)
    b:bench("load_user_config", setup.load_user_config)

    b:bench("base_options", setup.base_options)
    b:bench("base_keymaps", setup.base_keymaps)
    b:bench("base_autocmds", setup.base_autocmds)
    b:bench("base_lsp", setup.base_lsp)
    b:bench("base_commands", setup.base_commands)

    b:bench("plugin_which_key", setup.plugin_which_key)
    b:bench("plugin_nvim_treesitter", setup.plugin_nvim_treesitter)
    b:bench("bufferline", function() require("bufferline").setup({}) end)
    b:bench("plugin_bufferline_editor", setup.plugin_bufferline_editor);
    b:bench("cloak", function() require("cloak").setup({}) end)
    b:bench("Comment", function() require("Comment").setup({}) end)
    b:bench("plugin_luasnip", setup.plugin_luasnip)
    b:bench("plugin_blink_cmp", setup.plugin_blink_cmp)
    b:bench("plugin_gitsigns", setup.plugin_gitsigns)
    b:bench("plugin_lualine", setup.plugin_lualine)
    b:bench("plugin_neogit", setup.plugin_neogit)
    b:bench("plugin_todo_comments", setup.plugin_todo_comments)
    b:bench("plugin_undotree", setup.plugin_undotree)
    b:bench("plugin_treesitter_context", setup.plugin_treesitter_context)
    b:bench("plugin_snacks", setup.plugin_snacks)
    b:bench("tokyonight", function() require("tokyonight").setup({ style = "moon" }) end)
    b:bench("trouble", function() require("trouble").setup({}) end)
    b:bench("plugin_lsp_lines", setup.plugin_lsp_lines)
    b:bench("plugin_multicursor", setup.plugin_multicursor)
    b:bench("plugin_obsidian", setup.plugin_obsidian)
    b:bench("plugin_oil", setup.plugin_oil)
    b:bench("plugin_vim_table_mode", setup.plugin_vim_table_mode)
    b:bench("plugin_outline", setup.plugin_outline)
    b:bench("plugin_mini", setup.plugin_mini)
    b:bench("plugin_fff", setup.plugin_fff)
    b:bench("plugin_haunt", setup.plugin_haunt)
    b:bench("plugin_dap_and_dapui", setup.plugin_dap_and_dapui)

    b:bench("after_plugin_load_hooks", function()
        require('mugvim.hooks').run_after_plugin_load_hooks()
    end)
end

return M
