Mugway's Vim Config

===================

Mugvim is a Nix-based neovim distribution. Try it out by running `nix run git+https://git.loporrit.de/long/mugvim`.

Requires Neovim 0.12 or above.


## Options

### Format on Save

```lua
vim.g.mugvim_autoformat = true
```

### Obsidian

```lua
vim.g.mugvim_obsidian_workspaces = { { name = "...", path = "..." }, ... }
require("mugvim.hooks").after_plugin_load(function()
    vim.opt.conceallevel = 2
end)
```

### Snippets

```lua
vim.g.mugvim_snippets = vim.fn.std("data") .. "/snippets"
```

### Banner

```lua
vim.g.mugvim_banner = [[
... ascii art goes here ...
]]
```

### Custom Plugins

```lua
vim.pack.add({
    "https://github.com/nvim-mini/mini.jump",
})
require('mini.jump').setup()
```



```lua
vim.pack.add({
    "https://github.com/vuki656/package-info.nvim",
})
require('mini.jump').setup()
require("mugvim.util"):load_on_ft("plugin:package-info", { "json" }, function()
    require("package-info").setup({})
end)
```



### Hook: After Plugin Load

Use this to overwrite defaults, load colorschemes, etc.

```lua
require("mugvim.hooks").after_plugin_load(function()
    vim.cmd.colorscheme("kanagawa")
    require("oil").setup({ delete_to_trash = false })
    vim.opt.cursorline = false
    vim.opt.conceallevel = 2
end)
```
