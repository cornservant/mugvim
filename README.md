Mugway's Vim Config

===================

Requires Neovim 0.12 or above.

## Options

### Format on Save

```lua
vim.g.mugvim_autoformat = true
```

### Obsidian

```lua
vim.g.mugvim_obsidian_workspaces = { { name = "...", path = "..." }, ... }
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
