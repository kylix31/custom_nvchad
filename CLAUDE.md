# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a **NvChad v2.5-based** Neovim configuration using **lazy.nvim** as the plugin manager. The config imports NvChad as a base plugin and extends it with custom plugins and configurations.

### Directory Structure

```
nvim/
├── init.lua           # Entry point: bootstraps lazy.nvim, loads NvChad and plugins
├── minimal.lua        # Alternative minimal setup for testing/reproduction
├── lua/
│   ├── chadrc.lua      # NvChad UI/theme configuration (theme: chadracula)
│   ├── mappings.lua    # Custom keybindings (extends nvchad.mappings)
│   ├── options.lua     # Vim options (extends nvchad.options)
│   ├── autocmds.lua    # Auto commands (extends nvchad.autocmds)
│   ├── configs/        # Plugin configurations
│   └── plugins/        # Plugin specifications
```

### Key Components

- **Plugin Manager**: lazy.nvim (bootstrapped in init.lua)
- **Base Framework**: NvChad v2.5 (imported as "nvchad.plugins")
- **Theme**: chadracula (configured in lua/chadrc.lua)
- **Leader Key**: Space

## Plugin Organization

Plugins are organized in `lua/plugins/`:
- `init.lua` - Core plugins (conform.nvim, nvim-lspconfig)
- `custom.lua` - Extended plugins (fugitive, trouble, DAP, yanky, snacks, octo, etc.)
- `sidekick.lua` - Sidekick CLI integration (Zellij mux backend)
- `*.disabled` - Disabled AI plugins (avante.lua, codecompanion.lua)

All plugin configs in `lua/plugins/` return arrays of plugin specs that are auto-loaded by lazy.nvim.

## LSP Configuration

Located in `lua/configs/lspconfig.lua`. The LSP setup has a custom Vue/TypeScript integration pattern:

1. NvChad defaults are loaded first
2. Custom Vue/TypeScript plugin is configured via `setup_vue_typescript()`
3. Servers are listed and enabled via `vim.lsp.enable(servers)`

The Vue language server path is hardcoded to `/usr/bin/vue-language-server`.

## Formatting

Configured via `lua/configs/conform.lua` using conform.nvim:

- Format on save: enabled, 500ms timeout, LSP fallback
- Can be toggled per-buffer (`FormatDisable`, `FormatEnable` commands)
- Can format range (`:Format` command with range)

Formatters include: stylua, prettierd, eslint_d, ruff_format, rubocop, hadolint, shfmt, etc.

## Folding

Uses Treesitter-based folding by default (`foldexpr = "v:lua.vim.treesitter.foldexpr()"`). LSP folding is automatically applied for servers that support `textDocument/foldingRange`.

UFO folding is disabled but config exists in `lua/configs/ufo.lua`.

## Key Mappings

Custom mappings in `lua/mappings.lua`:
- Git (fugitive): `<leader>gh`, `<leader>gl`, `<leader>gs`, `<leader>gb`
- DAP debugging: F5 (continue), F10 (step over), F11 (step into), F12 (step out), `<leader>b` (toggle breakpoint)
- LSP: `<leader>ls` (diagnostics float), `<leader>ca` (code actions), `gi` (implementation)
- Buffers: `<leader>xa` (close all), `<leader>xo` (close others)
- JSON/YAML helpers: `<leader>jt`, `<leader>jf`, `<leader>yt`
- Yanky (enhanced yank/paste): `<a-p>` (previous), `<a-n>` (next)
- Snacks picker: `<leader><space>` (smart find), `<leader>,` (buffers), `<leader>/` (grep), `<leader>e` (explorer)

## Development Notes

### No Build/Test Commands

This is an editor configuration with no build/test scripts. Changes are made directly to Lua files and take effect on Neovim restart (or use `:Lazy sync` for plugin changes).

### Adding New Plugins

1. Add to appropriate file in `lua/plugins/`
2. If plugin requires configuration, create `lua/configs/<plugin-name>.lua` and require it in the plugin spec
3. Use lazy loading (`event`, `ft`, `cmd`, `keys`) where appropriate

### Adding LSP Servers

Edit `lua/configs/lspconfig.lua`:
1. Add server name to `servers` array
2. If server requires special config, use `vim.lsp.config("name", { ... })` before `vim.lsp.enable(servers)`

### Troubleshooting

- `minimal.lua` provides a reproducible environment for testing
- Disable plugins by adding `.disabled` suffix (lazy.nvim will skip them)
- Use `:Lazy health` to check plugin status
- Use `:LspInfo` to see active LSP servers
