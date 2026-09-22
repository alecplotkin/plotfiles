# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration (Neovim 0.12+) written in Lua. It uses **lazy.nvim** as the plugin manager.

## Plugin Management

lazy.nvim is bootstrapped in `lua/alpaca/lazy.lua`, which calls `require("lazy").setup("plugins", ...)`. Every file in `lua/plugins/` returns a plugin spec (or a list of specs) and is picked up automatically. Plugin versions are pinned in `lazy-lock.json`. Use `:Lazy` inside Neovim to install, update, or clean plugins.

## Architecture

The config loads via a single chain:

```
init.lua → lua/alpaca/init.lua → lua/alpaca/{remap,set,lazy}.lua
```

Plugin-specific configuration lives alongside each plugin's spec in `lua/plugins/<topic>.lua` (in `config`, `init`, `opts`, or `keys`). Filetype-specific settings are in `after/ftplugin/<ft>.lua`.

**Key directories:**
- `lua/alpaca/` — core config: keymaps (`remap.lua`), options (`set.lua`), lazy.nvim bootstrap (`lazy.lua`)
- `lua/plugins/` — plugin specs and their setup, grouped by topic (`lsp.lua`, `treesitter.lua`, `telescope.lua`, `navigation.lua`, `git.lua`, `explorer.lua`, `snippets.lua`, `latex.lua`, `jupyter.lua`, `markdown.lua`, `ui.lua`, `colorscheme.lua`, `dap.lua`, `snakemake.lua`)
- `after/ftplugin/` — filetype overrides (`tex.lua`, `markdown.lua`, `text.lua`)
- `snippets/` — LuaSnip snippet files in Lua format, loaded via `require("luasnip.loaders.from_lua")`
- `lua/utils/` — utility modules (currently `tex_fold.lua` for dynamically updating VimTeX fold types)

## Key Bindings

Leader is `<Space>`; local leader is `,`. Notable mappings:

| Key | Action |
|-----|--------|
| `<leader>pv` | Open oil.nvim (file explorer) |
| `<leader>pf` | Telescope find files |
| `<leader>pg` | Telescope git files |
| `<leader>ps` | Telescope grep string |
| `<leader>a` | Harpoon: add file |
| `<C-e>` | Harpoon: toggle quick menu |
| `<M-u/i/o/p>` | Harpoon: navigate to files 1–4 |
| `<leader>u` | Toggle undotree |
| `<leader>gs` | Open fugitive (git) |
| `<leader>gsv` | Open fugitive in a vertical split (`:Gitv`) |
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

Configured in `lua/plugins/lsp.lua` using Neovim's built-in `vim.lsp.config` / `vim.lsp.enable`, with Mason (`mason.nvim` + `mason-lspconfig.nvim`) installing the server binaries and `nvim-cmp` providing completion. Servers are listed once in a local `servers` table used for both `ensure_installed` and `vim.lsp.enable`:
- `pylsp`, `jedi_language_server` — Python
- `lua_ls` — Lua
- `r_language_server` — R (only when `Rscript` is on PATH)

LSP keymaps are set in an `LspAttach` autocmd.

## Treesitter

`lua/plugins/treesitter.lua` uses the `main` branch of nvim-treesitter, which compiles parsers with the `tree-sitter` CLI (`brew install tree-sitter-cli`). Parsers are installed to `stdpath('data')/site`. Treesitter highlighting is started for every filetype with an installed parser, except `tex`/`latex` (VimTeX handles those). Folding uses `vim.treesitter.foldexpr()`.

## Snippets

Snippet files in `snippets/` use LuaSnip's Lua loader format. The `snip_env` in `lua/plugins/snippets.lua` exposes `s`, `parse` (and commented-out `fmt`, `i`, `rep`) as globals within snippet files, so snippet files do **not** need to `require` LuaSnip themselves.

## LaTeX Workflow

- VimTeX is configured in `lua/plugins/latex.lua`. Compiler: `latexmk`, viewer: `zathura`
- Folding uses VimTeX's fold expressions (`vimtex#fold#level`)
- `lua/utils/tex_fold.lua` provides `M.update_fold_types()` to scan the buffer for `\newenvironment` declarations and add them to VimTeX's fold whitelist; exposed as `:UpdateFoldTypes` in `after/ftplugin/tex.lua`
- `tex.lua` ftplugin enables spell check, word wrap, and remaps `j`/`k` to `gj`/`gk` for wrapped lines (`markdown.lua` and `text.lua` do the same, minus folding)

## Jupyter Notebooks

Jupynium (`lua/plugins/jupyter.lua`) syncs `.ju.py` files (Jupytext format) with a running Jupyter Notebook server via Selenium. The conda environment named `jupynium` provides the Python host. Auto-attach is enabled for `*.ju.*` and `*.md` files; auto-start is disabled. Commands are mapped under the local leader (`,s` start server, `,a` start sync, `,q` stop sync, `,x` execute selected cells, `,c`/`,r` interrupt/restart kernel).

## Colorscheme

Kanagawa (`wave` theme) with a transparent background. Configured in `lua/plugins/colorscheme.lua`.
