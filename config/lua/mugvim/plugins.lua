local M = {}

function M.install_lazy()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    vim.opt.runtimepath:prepend(lazypath)
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--single-branch",
            "https://github.com/folke/lazy.nvim.git",
            lazypath,
        })
        return true
    end
    return false
end

function M.setup()
    M.install_lazy()

    local opts = {}

    require('lazy').setup('spec', opts)
end

return M
