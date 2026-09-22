# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration written in Lua. It uses **packer.nvim** as the plugin manager.

## Plugin Management

Plugins are declared in `lua/alpaca/packer.lua`. After adding or removing plugins, run `:PackerSync` inside Neovim to install/update/clean plugins. The compiled packer output lives at `lua/utils/packer_compiled.lua`.

## Architecture

The config loads via a single chain:

```
init.lua → lua/alpaca/init.lua → lua/alpaca/{remap,set,packer}.lua
```

Plugin-specific configuration lives in `after/plugin/<plugin>.lua` — these files are auto-sourced by Neovim after plugins load. Filetype-specific settings are in `after/ftplugin/<ft>.lua`.

**Key directories:**
- `lua/alpaca/` — core config: keymaps (`remap.lua`), options (`set.lua`), plugin declarations (`packer.lua`)
- `after/plugin/` — per-plugin setup and keybindings (one file per plugin)
- `after/ftplugin/` — filetype overrides (currently only `tex.lua`)
- `snippets/` — LuaSnip snippet files in Lua format, loaded via `require("luasnip.loaders.from_lua")`
- `lua/utils/` — utility modules (currently `tex_fold.lua` for dynamically updating VimTeX fold types)

## Key Bindings

Leader is `<Space>`. Notable mappings:

| Key | Action |
|-----|--------|
| `<leader>pv` | Open netrw (file explorer) |
| `<leader>pf` | Telescope find files |
| `<leader>pg` | Telescope git files |
| `<leader>ps` | Telescope grep string |
| `<leader>a` | Harpoon: add file |
| `<C-e>` | Harpoon: toggle quick menu |
| `<M-u/i/o/p>` | Harpoon: navigate to files 1–4 |
| `<leader>u` | Toggle undotree |
| `<leader>gs` | Open fugitive (git) |
| `<leader>gd` | LSP: go to definition |
| `<leader>vca` | LSP: code action |
| `<leader>vrr` | LSP: references |
| `<leader>vrn` | LSP: rename |
| `<leader>vd` | LSP: open diagnostics float |
| `<C-h>` | LSP: signature help |
| `<c-j>` / `<c-k>` | LuaSnip: jump forward/backward in snippet |
| `<c-l>` | LuaSnip: cycle choice node |
| `-` / `+` | Close/open fold |

## LSP

Configured via `lsp-zero` (v2.x branch) in `after/plugin/lsp.lua`. Managed servers (installed via Mason):
- `pylsp`, `jedi_language_server` — Python
- `lua_ls` — Lua
- `r_language_server` — R

## Snippets

Snippet files in `snippets/` use LuaSnip's Lua loader format. The `snip_env` in `after/plugin/luasnip.lua` exposes `s`, `parse` (and commented-out `fmt`, `i`, `rep`) as globals within snippet files, so snippet files do **not** need to `require` LuaSnip themselves.

## LaTeX Workflow

- Compiler: `latexmk`, viewer: `zathura`
- Folding uses VimTeX's fold expressions (`vimtex#fold#level`)
- `lua/utils/tex_fold.lua` provides `M.update_fold_types()` to scan the buffer for `\newenvironment` declarations and add them to VimTeX's fold whitelist; exposed as `:UpdateFoldTypes` in `after/ftplugin/tex.lua`
- Local leader for VimTeX mappings is `,`
- `tex.lua` ftplugin enables spell check, word wrap, and remaps `j`/`k` to `gj`/`gk` for wrapped lines

## Jupyter Notebooks

Jupynium syncs `.ju.py` files (Jupytext format) with a running Jupyter Notebook server via Selenium. The conda environment named `jupynium` provides the Python host. Auto-attach is enabled for `*.ju.*` and `*.md` files; auto-start is disabled.

## Colorscheme

Kanagawa (`wave` theme) with a transparent background. Configured in `after/plugin/colors.lua`.
