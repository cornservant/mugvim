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
        local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
        if next(buf_clients) == nil then
            -- TODO: clean up this if statement
            if type(msg) == "boolean" or #msg == 0 then
                return "LS Inactive"
            end
            return msg
        end
        local buf_client_names = {}

        -- add client
        for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" and client.name ~= "copilot" then
                table.insert(buf_client_names, client.name)
            end
        end

        local unique_client_names = vim.fn.uniq(buf_client_names)

        if unique_client_names == 0 then unique_client_names = {} end

        local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

        return language_servers
    end,
    color = { gui = "bold" },
}

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
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
                lualine_a = { 'mode' },
                lualine_b = { 'branch' },
                lualine_c = { 'diff' },
                lualine_x = { 'diagnostics', "require'lsp-status'.status()", 'filetype' },
                lualine_y = { 'location' },
                lualine_z = { progress }
            },
            inactive_sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch' },
                lualine_c = { 'diff' },
                lualine_x = { 'diagnostics', "require'lsp-status'.status()", 'filetype' },
                lualine_y = { 'location' },
                lualine_z = { progress }
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        })
    end,
}
