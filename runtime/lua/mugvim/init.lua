local M = {}

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

local function setup_lazy()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    vim.opt.rtp:prepend(lazypath)
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--single-branch",
            "https://github.com/folke/lazy.nvim.git",
            lazypath,
        })
    end

    local opts = {
        change_detection = {
            enabled = false,
        },
        profiling = {
            loader = true,
            require = true,
        },
    }

    require('lazy').setup('plugins', opts)
    vim.opt.rtp:prepend(M.runtime_path) -- `lazy` fucks up the runtime path, so we fix it here
end

local function set_base_settings()
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

    vim.diagnostic.config({ virtual_text = true })
end

local function set_base_keymaps()
    vim.g.mapleader = ' '

    vim.keymap.set('i', '<C-c>', '<Esc>')

    vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
    vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
    vim.keymap.set('n', '<leader>k', '<cmd>cnext<CR>zz')
    vim.keymap.set('n', '<leader>j', '<cmd>cprev<CR>zz')

    vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>')
    vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>')
    vim.keymap.set('n', '<C-h>', '<cmd>wincmd h<cr>')
    vim.keymap.set('n', '<C-j>', '<cmd>wincmd j<cr>')
    vim.keymap.set('n', '<C-k>', '<cmd>wincmd k<cr>')
    vim.keymap.set('n', '<C-l>', '<cmd>wincmd l<cr>')
    vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')
    vim.keymap.set('i', '<M-backspace>', '<c-w>')
end

local function set_base_autocmds()
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

local function load_user_config()
    local user_config_path = vim.fn.stdpath("config") .. "/config.lua";
    if vim.fn.filereadable(user_config_path) == 1 then
        local ok, _ = pcall(dofile, user_config_path)
        if not ok then
            vim.notify("error in user config " .. user_config_path, vim.log.levels.ERROR)
        end
    end
end

local function fix_bufferline_colors()
    -- NOTE: for some reason `bufferline` doesn't color corectly when calling `vim.cmd.colorscheme` only once, so we call it here pre-emptively, so that subsequent calls work as expected
    vim.cmd.colorscheme("default")
end

local function setup_lsp()
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(ev)
            require('which-key').add({
                { "<leader>l",  buffer = ev.buf,                                    group = "LSP" },
                { "<leader>lR", vim.lsp.buf.references,                             buffer = ev.buf, desc = "References" },
                { "<leader>la", vim.lsp.buf.code_action,                            buffer = ev.buf, desc = "Code Action" },
                { "<leader>ld", vim.diagnostic.open_float,                          buffer = ev.buf, desc = "Diagnostic" },
                { "<leader>lf", function() vim.lsp.buf.format { async = true } end, buffer = ev.buf, desc = "Format" },
                { "<leader>ll", require("lsp_lines").toggle,                        buffer = ev.buf, desc = "Toggle lsp_lines" },
                { "<leader>lr", vim.lsp.buf.rename,                                 buffer = ev.buf, desc = "Rename" },
                { "<leader>lw", vim.lsp.buf.workspace_symbol,                       buffer = ev.buf, desc = "Workspace Symbols" },
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

function M:init(runtime_path)
    M.runtime_path = runtime_path
    fix_bufferline_colors()
    load_user_config()
    set_base_settings()
    set_base_keymaps()
    setup_lazy()
    set_base_autocmds()
    setup_lsp()
    require('mugvim.hooks').run_after_plugin_load_hooks()
end

return M
