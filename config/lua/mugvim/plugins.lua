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

    local plugins = {
        'folke/lazy.nvim',

        require('mugvim.spec.which-key'),
        'folke/neodev.nvim',
        require('mugvim.spec.tokyonight'),
        require('mugvim.spec.trouble'),
        'rose-pine/neovim',
        require('mugvim.spec.everforest'),
        'cocopon/iceberg.vim',
        'arcticicestudio/nord-vim',
        'catppuccin/vim',
        'morhetz/gruvbox',
        require('mugvim.spec.onedark'),
        'tpope/vim-surround',
        'tpope/vim-repeat',
        'NoahTheDuke/vim-just',
        'junegunn/vim-peekaboo',
        require('mugvim.spec.harpoon'),
        'editorconfig/editorconfig-vim',
        require('mugvim.spec.indent_blankline'),
        require('mugvim.spec.telescope'),
        require('mugvim.spec.lualine'),
        require('mugvim.spec.symbols-outline'),
        require('mugvim.spec.nvim-tree'),
        require('mugvim.spec.treesitter'),
        require('mugvim.spec.gitsigns'),
        require('mugvim.spec.bufferline'),
        require('mugvim.spec.undotree'),
        require('mugvim.spec.comment'),
        require('mugvim.spec.dashboard'),
        require('mugvim.spec.neogit'),
        require('mugvim.spec.fugitive'),
        require('mugvim.spec.lsp'),
    }

    require('lazy').setup(plugins, opts)
end

return M
