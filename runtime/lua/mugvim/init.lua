local M = {}

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

function M:init(runtime_path)
    M.runtime_path = runtime_path
    fix_bufferline_colors()
    load_user_config()
    set_base_settings()
    set_base_keymaps()
    setup_lazy()
    set_base_autocmds()
    require('mugvim.hooks').run_after_plugin_load_hooks()
end

return M
