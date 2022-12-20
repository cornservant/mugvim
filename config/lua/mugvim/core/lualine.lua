local M = {}

-- these settings are mostly yoinked from LunarVIM

local icons = require 'lvim.icons'
local colors = require 'lvim.lualine-colors'

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local mode = {
    function()
        return " " .. icons.ui.Target .. " "
    end,
    padding = { left = 0, right = 0 },
    color = {},
    cond = nil,
}
local branch = {
    "b:gitsigns_head",
    icon = icons.git.Branch,
    color = { gui = "bold" },
}

local diff = {
    "diff",
    source = diff_source,
    symbols = {
        added = icons.git.LineAdded .. " ",
        modified = icons.git.LineModified .. " ",
        removed = icons.git.LineRemoved .. " ",
    },
    padding = { left = 2, right = 1 },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
    },
    cond = nil,
}

local spaces = {
    function()
        local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
        return icons.ui.Tab .. " " .. shiftwidth
    end,
    padding = 1,
}

local progress = {
    "progress",
    fmt = function()
        return "%P/%L"
    end,
    color = {},
}

local lsp = {
    function(msg)
        msg = msg or "LS Inactive"
        local buf_clients = vim.lsp.buf_get_clients()
        if next(buf_clients) == nil then
            -- TODO: clean up this if statement
            if type(msg) == "boolean" or #msg == 0 then
                return "LS Inactive"
            end
            return msg
        end
        local buf_ft = vim.bo.filetype
        local buf_client_names = {}

        -- add formatter
        local formatters = require "lvim.lsp.null-ls.formatters"
        local supported_formatters = formatters.list_registered(buf_ft)
        vim.list_extend(buf_client_names, supported_formatters)

        -- add linter
        local linters = require "lvim.lsp.null-ls.linters"
        local supported_linters = linters.list_registered(buf_ft)
        vim.list_extend(buf_client_names, supported_linters)

        local unique_client_names = vim.fn.uniq(buf_client_names)

        local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

        return language_servers
    end,
    color = { gui = "bold" },
}

function M.setup()
    require('lualine').setup({
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                "dashboard",
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { mode },
            lualine_b = { branch },
            lualine_c = { diff },
            lualine_x = { 'diagnostics', lsp, spaces, 'filetype' },
            lualine_y = { 'location' },
            lualine_z = { progress }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    })
end

return M
