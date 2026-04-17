require('nvim-treesitter').setup {
    install_dir = vim.fn.stdpath('data') .. '/site'
}

require('nvim-treesitter').install { 'python', 'lua', 'c', 'vim', 'vimdoc', 'query', 'yaml', 'markdown', 'markdown_inline', 'snakemake' }

-- Neovim only auto-starts treesitter for lua/markdown/help/query; enable it
-- for everything else that has an installed parser.
vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})

-- Disable treesitter highlighting for latex (VimTeX handles it instead)
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'tex', 'latex' },
    callback = function(ev)
        vim.treesitter.stop(ev.buf)
    end,
})

-- Treesitter-based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
