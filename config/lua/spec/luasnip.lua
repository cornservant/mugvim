local mugvimPaths = require("mugvim.bootstrap")

return {
    "L3MON4D3/LuaSnip",
    lazy = false,
    version = "v2.*",
    -- build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")

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

        require("luasnip.loaders.from_snipmate").lazy_load({ paths = mugvimPaths.base_dir .. "/snippets" })
    end,
}
