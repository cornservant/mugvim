local M = {}

function M:fix_bufferline_colors()
    -- NOTE: for some reason `bufferline` doesn't color corectly when calling `vim.cmd.colorscheme` only once, so we call it here pre-emptively, so that subsequent calls work as expected
    vim.cmd.colorscheme("default")
end

function M:load_user_config()
    local user_config_path = require("mugvim"):user_config_path()
    if vim.fn.filereadable(user_config_path) == 1 then
        local ok, error = pcall(dofile, user_config_path)
        if not ok then
            vim.notify("error in user config " .. user_config_path, vim.log.levels.ERROR)
            vim.notify(error, vim.log.levels.ERROR)
        end
    end
end

function M:base_options()
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 4
    vim.opt.tabstop = 4
    vim.opt.smartindent = true
    vim.opt.errorbells = false
    vim.opt.timeoutlen = 250
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.clipboard = "unnamedplus"
    vim.opt.fileencoding = "utf-8"
    vim.opt.termguicolors = true
    vim.opt.hlsearch = true
    vim.opt.incsearch = true
    vim.opt.signcolumn = "yes"
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.showcmd = false
    vim.opt.cursorline = true
    vim.opt.showmode = true
    vim.opt.mouse = "a"
    vim.opt.ignorecase = true
    vim.opt.conceallevel = 0
    vim.opt.cmdheight = 1
    vim.opt.laststatus = 3
    vim.opt.undofile = true
    vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
    vim.opt.shadafile = vim.fn.stdpath("cache") .. "/mugvim.shada"
    vim.opt.showmode = false
    vim.opt.scrolloff = 8
    vim.opt.sidescrolloff = 8
    vim.opt.diffopt:append("vertical")
end

function M:base_keymaps()
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ','

    vim.keymap.set('i', '<C-c>', '<Esc>')

    vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
    vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
    vim.keymap.set('n', '<leader>k', '<cmd>cnext<CR>zz')
    vim.keymap.set('n', '<leader>j', '<cmd>cprev<CR>zz')

    vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>')
    vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>')
    vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')
    vim.keymap.set('i', '<M-backspace>', '<c-w>')
end

function M:base_autocmds()
    local function has_lsp_formatting()
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({ bufnr = bufnr })

        if #clients == 0 then
            return false, "No LSP clients attached to this buffer."
        end

        for _, client in ipairs(clients) do
            if client.supports_method("textDocument/formatting") or
                client.supports_method("textDocument/rangeFormatting") then
                return true, nil -- LSP supports formatting
            end
        end

        return false, "No attached LSP client supports formatting for this buffer."
    end

    vim.api.nvim_create_autocmd("FileType", {
        pattern = {
            "help",
            "startuptime",
            "qf",
            "lspinfo",
            "man",
            "checkhealth"
        },
        command = [[
        nnoremap <buffer><silent> q :close<CR>
        set nobuflisted
        ]],
    })

    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = "*",
        group = vim.api.nvim_create_augroup("lsp_format_on_save", {}),
        callback = function()
            if has_lsp_formatting() and vim.g.mugvim_autoformat then
                vim.lsp.buf.format()
            end
        end,
    })
end

function M:base_lsp()
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(ev)
            require('which-key').add({
                { "<leader>l",  buffer = ev.buf,                                       group = "LSP" },
                { "<leader>lR", vim.lsp.buf.references,                                buffer = ev.buf, desc = "References" },
                { "<leader>la", vim.lsp.buf.code_action,                               buffer = ev.buf, desc = "Code Action" },
                { "<leader>ld", vim.diagnostic.open_float,                             buffer = ev.buf, desc = "Diagnostic" },
                { "<leader>lf", function() vim.lsp.buf.format { async = true } end,    buffer = ev.buf, desc = "Format" },
                { "<leader>lr", vim.lsp.buf.rename,                                    buffer = ev.buf, desc = "Rename" },
                { "<leader>lw", vim.lsp.buf.workspace_symbol,                          buffer = ev.buf, desc = "Workspace Symbols" },
                { "<leader>tl", require("lsp_lines").toggle,                           buffer = ev.buf, desc = "Toggle lsp_lines" },
                { "<leader>lt", function() require("trouble").open("diagnostics") end, buffer = ev.buf, desc = "Trouble: Error" },
            })

            local opts = { buffer = ev.buf }

            vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
            vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
            vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
            vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
            vim.keymap.set("n", "gc", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
            vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        end,
    })

    local capabilities = {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
        },
    }

    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

    vim.lsp.config("*", {
        capabilities = capabilities,
        root_markers = { ".git" },
    })

    vim.lsp.enable({ 'lua_ls' })
end

function M:base_commands()
    local function toggle_format_on_write()
        vim.g.mugvim_autoformat = not vim.g.mugvim_autoformat
    end
    vim.api.nvim_create_user_command("MugvimEditUserConfig", function() require("mugvim"):edit_user_config() end, {})
    vim.api.nvim_create_user_command("MugvimVersion", function() print(require("mugvim"):version()) end, {})
    vim.api.nvim_create_user_command("MugvimToggleFormatOnWrite", toggle_format_on_write, {})

    require("which-key").add({
        { "<leader>tf", toggle_format_on_write, desc = "Toggle Format on Write" },
    })
end

function M:plugin_which_key()
    require("which-key").setup({})
    require('which-key').add({
        { "<leader>+",  group = "Mugvim" },
        { "<leader>b",  group = "Buffer" },
        { "<leader>c",  vim.cmd.bdelete,  desc = "Close Buffer" },
        { "<leader>f",  group = "File" },
        { "<leader>g",  group = "Git" },
        { "<leader>q",  vim.cmd.quit,     desc = "Quit" },
        { "<leader>s",  group = "Search" },
        { "<leader>t",  group = "Toggle" },
        { "<leader>th", group = "History" },
        { "<leader>w",  vim.cmd.write,    desc = "Write" },
    })
end

function M:plugin_luasnip()
    local ls = require("luasnip")

    local function snippet_path()
        return vim.g.mugvim_snippets or vim.fn.stdpath("data") .. "/snippets"
    end

    local loadSnippets = function()
        require("luasnip.loaders.from_snipmate")
            .lazy_load({ paths = snippet_path() })
    end

    local openSnippets = function()
        vim.cmd.edit(snippet_path())
    end

    local expand_or_jump = function(dir)
        local key
        if dir == 1 then
            key = "<Tab>"
        else
            key = "<S-Tab>"
        end
        if ls.jumpable(dir) then
            ls.jump(dir)
        else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", false)
        end
    end

    vim.keymap.set({ "i", "s" }, "<Tab>", function() expand_or_jump(1) end, { remap = false })
    vim.keymap.set({ "i", "s" }, "<S-Tab>", function() expand_or_jump(-1) end, { remap = false })

    loadSnippets()

    require('which-key').add({
        { "<leader>S",  group = "Snippets" },
        { "<leader>Sr", loadSnippets,      desc = "Reload snippets" },
        { "<leader>So", openSnippets,      desc = "Open snippets" },
    })
end

function M:plugin_blink_cmp()
    require("blink.cmp").setup({
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- see the "default configuration" section below for full documentation on how to define
        -- your own keymap.
        -- NOTE: I am using a modified 'enter' preset
        keymap = {
            preset = 'none',
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<C-y>'] = { 'accept', 'fallback' },
            ['<C-.>'] = { 'accept', 'fallback' },

            ['<Tab>'] = { 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'show', 'select_next', 'fallback_to_mappings' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        -- completion = {
        --   menu = { auto_show = function(ctx) return ctx.mode ~= 'cmdline' end }
        -- },
        completion = {
            menu = {
                draw = {
                    treesitter = { 'lsp' },
                    columns = {
                        { 'label',     'label_description', gap = 1 },
                        { 'kind_icon', 'kind' },
                    },
                },
            },

            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
        },
        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release
            use_nvim_cmp_as_default = false,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'normal',
        },

        fuzzy = {
            implementation = "prefer_rust_with_warning",
            prebuilt_binaries = {
                download = false,
            },
        },

        snippets = {
            preset = 'luasnip',
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        -- experimental signature help support
        signature = { enabled = true },
    })
end

function M:plugin_bufferline_editor()
    require("bufferline-editor").setup({
        max_width = 80,
        max_height = 24,
    })
    require("which-key").add({
        { "<c-e>",      function() require("bufferline-editor").editor_toggle() end, desc = "Edit Buffers" },
        { "<leader>be", function() require("bufferline-editor").editor_toggle() end, desc = "Edit Buffers" },
    })
end

function M:plugin_gitsigns()
    require("gitsigns").setup({})
    require("which-key").add({
        { "[g",         function() require('gitsigns').next_hunk({ navigation_message = false }) end, desc = "Next Hunk" },
        { "]g",         function() require('gitsigns').prev_hunk({ navigation_message = false }) end, desc = "Prev Hunk" },
        { "<leader>gl", function() require('gitsigns').blame_line() end,                              desc = "Blame" },
        { "<leader>gp", function() require('gitsigns').preview_hunk() end,                            desc = "Preview Hunk" },
        { "<leader>gr", function() require('gitsigns').reset_hunk() end,                              desc = "Reset Hunk" },
        { "<leader>gR", function() require('gitsigns').reset_buffer() end,                            desc = "Reset Buffer" },
        { "<leader>gs", function() require('gitsigns').stage_hunk() end,                              desc = "Stage Hunk" },
        { "<leader>gu", function() require('gitsigns').undo_stage_hunk() end,                         desc = "Undo Stage Hunk" },
        { "<leader>gd", function() require('gitsigns').diffthis() end,                                desc = "Git Diff" },
    })
end

function M:plugin_neogit()
    require("neogit").setup({})
    require("which-key").add({
        { "<leader>gg", function() require('neogit').open() end, desc = "Neogit" },
    })
end

function M:plugin_nvim_tree_sitter()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    ts_update()

    vim.filetype.add({
        extension = {
            c3 = "c3",
            c3i = "c3",
            c3t = "c3",
        },
    })

    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.c3 = {
        install_info = {
            url = "https://github.com/c3lang/tree-sitter-c3",
            files = { "src/parser.c", "src/scanner.c" },
            branch = "main",
        },
    }

    require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "dockerfile",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "html",
            "javascript",
            "json",
            "lua",
            "make",
            "nix",
            "php",
            "python",
            "r",
            "regex",
            "rust",
            "scss",
            "sql",
            "svelte",
            "toml",
            "tsx",
            "typescript",
            "vimdoc",
            "yaml",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
    }
end

function M:plugin_outline()
    require("which-key").add({
        { "<leader>o", function() require 'outline'.open() end, desc = "Open Outline" }
    })
end

function M:plugin_todo_comments()
    require("todo-comments").setup({})
    require("which-key").add({
        { "[t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        { "]t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    })
end

function M:plugin_undotree()
    require("which-key").add({
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Undo Tree" },
    })
end

function M:plugin_lualine()
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
                table.insert(buf_client_names, client.name)
            end

            local unique_client_names = vim.fn.uniq(buf_client_names)

            if unique_client_names == 0 then unique_client_names = {} end

            local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

            return language_servers
        end,
        color = { gui = "bold" },
    }

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
            lualine_x = { 'diagnostics', lsp, 'filetype' },
            lualine_y = { 'location' },
            lualine_z = { progress }
        },
        inactive_sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = { 'diff' },
            lualine_x = { 'diagnostics', lsp, 'filetype' },
            lualine_y = { 'location' },
            lualine_z = { progress }
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    })
end

function M:plugin_treesitter_context()
    require("treesitter-context").setup({ enable = false })
    require("which-key").add({
        { "<leader>tc", function() require 'treesitter-context'.toggle() end, desc = "Toggle treesitter context" },
    })
end

function M:plugin_lsp_lines()
    vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = {
            only_current_line = true,
        },
    })
end

function M:plugin_snacks()
    local mugvim = require("mugvim")
    local default_header = [[


  /\_/\
 ( o.o )
  > ^ <

マッグヴィム
(v]] .. mugvim:version() .. [[)

in Gedenken an
Bram Moolenaar]]

    require("snacks").setup({
        bigfile = { enabled = true },
        bufdelete = { enabled = true },
        dashboard = {
            enabled = true,
            width = 32,
            pane_gap = 2,
            preset = {
                header = vim.g.mugvim_banner or default_header,
                keys = {
                    {
                        icon = '󰝒  ',
                        desc = 'New Buffer             ',
                        action = function() vim.cmd('enew') end,
                        key = 'n',
                    },
                    {
                        icon = '󱋡  ',
                        desc = 'Recent Files           ',
                        action = function() require 'snacks.picker'.recent() end,
                        key = 'r',
                    },
                    {
                        icon = '󰗶  ',
                        desc = 'Check Health           ',
                        action = function() vim.cmd("checkhealth") end,
                        key = 'h',
                    },
                    {
                        icon = '  ',
                        desc = 'Edit Config            ',
                        action = mugvim.edit_user_config,
                        key = 'c',
                    },
                },
            },
            sections = {
                { section = "header" },
                { section = "keys",  gap = 0, padding = 2 },
            },
        },
        indent = {
            enabled = true,
            animate = { enabled = false },
        },
        image = { enabled = true },
        notifier = { enabled = true },
        picker = { enabled = true },
        quickfile = { enabled = true },
    })

    require("which-key").add({
        -- Top Pickers & Explorer
        { "<leader><space>", function() require 'snacks.picker'.smart() end,                                   desc = "Smart Find Files" },
        { "<leader>,",       function() require 'snacks.picker'.buffers() end,                                 desc = "Buffers" },
        { "<leader>/",       function() require 'snacks.picker'.grep() end,                                    desc = "Grep" },
        { "<leader>:",       function() require 'snacks.picker'.command_history() end,                         desc = "Command History" },
        { "<leader>E",       function() require 'snacks'.explorer() end,                                       desc = "File Explorer" },
        -- find
        { "<leader>fb",      function() require 'snacks.picker'.buffers() end,                                 desc = "Buffers" },
        { "<leader>fc",      function() require 'snacks.picker'.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff",      function() require 'snacks.picker'.files() end,                                   desc = "Find Files" },
        { "<leader>fg",      function() require 'snacks.picker'.git_files() end,                               desc = "Find Git Files" },
        { "<leader>fp",      function() require 'snacks.picker'.projects() end,                                desc = "Projects" },
        { "<leader>fr",      function() require 'snacks.picker'.recent() end,                                  desc = "Recent" },
        -- git
        { "<leader>gtb",     function() require 'snacks.picker'.git_branches() end,                            desc = "Git Branches" },
        { "<leader>gtl",     function() require 'snacks.picker'.git_log() end,                                 desc = "Git Log" },
        { "<leader>gtL",     function() require 'snacks.picker'.git_log_line() end,                            desc = "Git Log Line" },
        { "<leader>gts",     function() require 'snacks.picker'.git_status() end,                              desc = "Git Status" },
        { "<leader>gtS",     function() require 'snacks.picker'.git_stash() end,                               desc = "Git Stash" },
        { "<leader>gtd",     function() require 'snacks.picker'.git_diff() end,                                desc = "Git Diff (Hunks)" },
        { "<leader>gtf",     function() require 'snacks.picker'.git_log_file() end,                            desc = "Git Log File" },
        -- Grep
        { "<leader>sb",      function() require 'snacks.picker'.lines() end,                                   desc = "Buffer Lines" },
        { "<leader>sB",      function() require 'snacks.picker'.grep_buffers() end,                            desc = "Grep Open Buffers" },
        { "<leader>sg",      function() require 'snacks.picker'.grep() end,                                    desc = "Grep" },
        { "<leader>sw",      function() require 'snacks.picker'.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>s"',      function() require 'snacks.picker'.registers() end,                               desc = "Registers" },
        { '<leader>s/',      function() require 'snacks.picker'.search_history() end,                          desc = "Search History" },
        { "<leader>sa",      function() require 'snacks.picker'.autocmds() end,                                desc = "Autocmds" },
        { "<leader>sb",      function() require 'snacks.picker'.lines() end,                                   desc = "Buffer Lines" },
        { "<leader>sc",      function() require 'snacks.picker'.command_history() end,                         desc = "Command History" },
        { "<leader>sC",      function() require 'snacks.picker'.commands() end,                                desc = "Commands" },
        { "<leader>sd",      function() require 'snacks.picker'.diagnostics() end,                             desc = "Diagnostics" },
        { "<leader>sD",      function() require 'snacks.picker'.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
        { "<leader>sh",      function() require 'snacks.picker'.help() end,                                    desc = "Help Pages" },
        { "<leader>sH",      function() require 'snacks.picker'.highlights() end,                              desc = "Highlights" },
        { "<leader>si",      function() require 'snacks.picker'.icons() end,                                   desc = "Icons" },
        { "<leader>sj",      function() require 'snacks.picker'.jumps() end,                                   desc = "Jumps" },
        { "<leader>sk",      function() require 'snacks.picker'.keymaps() end,                                 desc = "Keymaps" },
        { "<leader>sl",      function() require 'snacks.picker'.loclist() end,                                 desc = "Location List" },
        { "<leader>sm",      function() require 'snacks.picker'.marks() end,                                   desc = "Marks" },
        { "<leader>sM",      function() require 'snacks.picker'.man() end,                                     desc = "Man Pages" },
        { "<leader>sn",      function() require 'snacks.picker'.notifications() end,                           desc = "Notification History" },
        { "<leader>sq",      function() require 'snacks.picker'.qflist() end,                                  desc = "Quickfix List" },
        { "<leader>sR",      function() require 'snacks.picker'.resume() end,                                  desc = "Resume" },
        { "<leader>su",      function() require 'snacks.picker'.undo() end,                                    desc = "Undo History" },
        -- extra
        { "<leader>+c",      function() require 'snacks.picker'.colorschemes() end,                            desc = "Colorschemes" },
        -- image fix
        { "<leader>ti",      function() require 'mugvim.snacks_image_fix'.toggle_snacks_image() end,           desc = "Toggle image preview" },
    })
end

function M:plugin_multicursor()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
    set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
    set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
    set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
    set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
    set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
    set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

    -- Add and remove cursors with control + left click.
    set("n", "<c-leftmouse>", mc.handleMouse)
    set("n", "<c-leftdrag>", mc.handleMouseDrag)
    set("n", "<c-leftrelease>", mc.handleMouseRelease)

    -- Disable and enable cursors.
    set({ "n", "x" }, "<c-q>", mc.toggleCursor)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            else
                mc.clearCursors()
            end
        end)
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
end

function M:plugin_obsidian()
    if vim.g.mugvim_obsidian_workspaces and true or false then
        require("obsidian").setup({
            workspaces = vim.g.mugvim_obsidian_workspaces or {},
            picker = { name = "snacks.pick" },
        })
        require("which-key").add({
            { "<leader>Ob", "<cmd>ObsidianBacklinks<cr>",   desc = "Backlinks" },
            { "<leader>On", "<cmd>ObsidianNew<cr>",         desc = "New" },
            { "<leader>Oo", "<cmd>ObsidianOpen<cr>",        desc = "Open" },
            { "<leader>Ot", "<cmd>ObsidianToday<cr>",       desc = "Today" },
            { "<leader>Oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "QuickSwitch" },
            { "<leader>Of", "<cmd>ObsidianFollowLink<cr>",  desc = "FollowLink" },
            { "<leader>Os", "<cmd>ObsidianSearch<cr>",      desc = "Search" },
            { "<leader>Od", "<cmd>ObsidianDailies<cr>",     desc = "Dailies" },
        })
    end
end

function M:plugin_oil()
    require("oil").setup({
        view_options = {
            show_hidden = true,
        },
        delete_to_trash = true,
    })
    require("which-key").add({
        { "<leader>e",  function() require("oil").open() end,                          desc = "File Browser" },
        { "<leader>ft", function() require("oil.actions").toggle_trash.callback() end, desc = "Browse Trash" },
    })
end

function M:plugin_vim_table_mode()
    require("mugvim.util"):load_on_ft("plugin:vim-table-mode", { "markdown" }, function()
        vim.g.table_mode_disable_mappings = 1
        vim.g.table_mode_disable_tableize_mappings = 1
        require("which-key").add({
            { "<localleader>f",    group = "Formula" },
            { "<localleader>t",    function() vim.cmd("TableModeToggle") end,                                    ft = "markdown", desc = "Toggle table mode" },

            { "<localleader>x",    function() vim.call("tablemode#spreadsheet#DeleteColumn") end,                ft = "markdown", desc = "Delete column" },

            { "<localleader>i",    function() vim.call("tablemode#spreadsheet#InsertColumn", 0) end,             ft = "markdown", desc = "Insert column before" },
            { "<localleader>a",    function() vim.call("tablemode#spreadsheet#InsertColumn", 1) end,             ft = "markdown", desc = "Insert column after" },

            { "<localleader>h",    function() vim.call("tablemode#spreadsheet#cell#Motion", "h") end,            ft = "markdown", desc = "Motion left" },
            { "<localleader>j",    function() vim.call("tablemode#spreadsheet#cell#Motion", "j") end,            ft = "markdown", desc = "Motion down" },
            { "<localleader>k",    function() vim.call("tablemode#spreadsheet#cell#Motion", "k") end,            ft = "markdown", desc = "Motion up" },
            { "<localleader>l",    function() vim.call("tablemode#spreadsheet#cell#Motion", "l") end,            ft = "markdown", desc = "Motion right" },

            { "<localleader>?",    function() vim.call("tablemode#spreadsheet#EchoCell") end,                    ft = "markdown", desc = "Echo cell" },
            { "<localleader>s",    function() vim.call("tablemode#spreadsheet#Sort", "") end,                    ft = "markdown", desc = "Sort" },

            { "<localleader>f",    function() vim.call("tablemode#spreadsheet#formula#Add") end,                 ft = "markdown", desc = "Add" },
            { "<localleader><cr>", function() vim.call("tablemode#spreadsheet#formula#EvaluateFormulaLine") end, ft = "markdown", desc = "Evaluate formula line" },

            { "<localleader>=",    function() vim.call("tablemode#table#Realign", ".") end,                      ft = "markdown", desc = "Realign" },
        })
    end)
end

return M
