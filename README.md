Mugway's Vim Config
===================

## Installation

Use Nix flakes or the `bin/mugvim` script (requires the `MUGVIM_BASE_DIR` environment variable to point to the checked out git repository.

## NixOS

Enable `nix-ld` in order to run lsp server binaries downloaded by Mason.

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
