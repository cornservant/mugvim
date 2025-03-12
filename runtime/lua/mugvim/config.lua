local M = {}

function M.setup()
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

return M
