# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager, written entirely in Lua (plus some legacy VimScript in `viml/`).

## Setup / Install

```sh
# First-time install: sync all plugins headlessly
NVIM_APPNAME=PangPangPangPangPang/mxvim/ nvim --headless +"Lazy! sync" +qa

# Launch with this config
NVIM_APPNAME=PangPangPangPangPang/mxvim/ nvim
```

Inside Neovim, `:PS` runs `require('lazy').sync()`.

## Code style

Lua is formatted with **stylua** (`stylua.toml`): 2-space indent, 120-column width, double quotes. Linted with **selene** (`selene.toml`).

## Architecture

### Boot sequence

```
init.lua
  → enables vim.loader (bytecode cache at ~/.cache/nvim/luac/)
  → require("mxvim")   -- global config object (_G.mxvim)
  → require("basic")   -- vim options, autocommands, filetype rules
  → require("map")     -- leader key and base keymaps
  → require("utils").load_plugins()  -- bootstraps lazy.nvim, loads lua/plugins/
```

### Global config: `lua/mxvim.lua`

`_G.mxvim` is the single place to toggle features and pick active variants:

| Key | Options / purpose |
|-----|-------------------|
| `mxvim.current_theme` | Active colorscheme name |
| `mxvim.style` | Statusline style: `"simple"` / `"pure"` / `"normal"` |
| `mxvim.ai_engine` | `"supermaven"` / `"copilot"` / `"codeium"` |
| `mxvim.use_cmp` / `mxvim.use_coc` | Toggle completion engine |
| `mxvim.enable_treesitter` | Master treesitter toggle |
| `mxvim.lsp` | List of mason-managed LSP servers to activate |
| `mxvim.ignore_list` | Filetypes where `q` quick-closes the window |

Plugin specs reference these flags via `enabled = mxvim.<flag>` to conditionally load plugins.

### Plugin specs: `lua/plugins/`

Each file returns a Lua table of lazy.nvim plugin specs, loaded automatically by `load_plugins()`. Files are grouped by domain:

- `ai.lua` — supermaven, copilot, codeium, sidekick.nvim (AI CLI), ChatGPT
- `lsp.lua` — mason, blink.cmp (primary completion), lspconfig, trouble, conform, null-ls
- `edit.lua` — comments, surround, flash motion, folding, markdown, refactoring
- `fuzzy.lua` — telescope + extensions
- `git.lua` — gitsigns, diffview, fugitive
- `ui.lua` — lualine, noice, notify, indent-blankline, satellite scrollbar, incline
- `treesitter.lua` — treesitter, textobjects, hlargs, autotag
- `tree.lua` — nvim-tree (default), neo-tree (opt-in via `mxvim.enable_neotree`)
- `debug.lua` — nvim-dap + dap-ui

### Plugin configs: `lua/config/`

Heavy plugin configuration is extracted into individual `_<plugin>.lua` files (prefixed with `_` by convention) and called from the plugin spec's `config` function. For example `_lualine.lua`, `_mason.lua`, `_lsp_config.lua`.

### Theme system: `lua/colorscheme/` + `lua/theme.lua`

Each file in `lua/colorscheme/` exposes a `colors()` function returning a palette. `theme.lua` reads `mxvim.current_theme`, loads the matching colorscheme file, applies highlights, and sets up statusline colors. Three lualine configs exist (`_lualine.lua`, `_lualine_pure.lua`, `_lualine_simple.lua`) selected by `mxvim.style`.

### Utility helpers: `lua/utils.lua`

- `M.map(modes, lhs, rhs, opts)` / `M.dmap(modes, lhs, rhs, desc)` — keymap wrappers
- `M.opt(key, value, scopes)` — vim option setter
- `M.safe_require(mod)` — silent require with nil fallback
- `M.create_augroups(defs)` — batch autocommand creation
- `M.blend(fg, bg, alpha)` / `M.get_color(hl, attr)` — color utilities for themes

### sidekick.nvim terminal keymaps

The sidekick terminal (Claude CLI, Gemini, etc.) uses buffer-local terminal-mode mappings set via `TermOpen` autocmd in `ai.lua`:
- `<Esc>` — sends Esc to the CLI process
- `<Esc><Esc>` — exits terminal mode back to normal mode (`<C-\><C-n>`)
