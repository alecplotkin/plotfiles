local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Colorscheme
    'rebelot/kanagawa.nvim',

    -- Syntax
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },

    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = 'make install_jsregexp',
    },

    -- Navigation
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',

    -- LSP / Completion
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },

    -- Snakemake (rtp= adds that repo subdirectory to runtimepath)
    { 'snakemake/snakemake', rtp = 'misc/vim', ft = 'snakemake' },
    'snakemake/snakefmt',

    -- Debugging
    'mfussenegger/nvim-dap',

    -- Jupyter
    {
        'kiyoon/jupynium.nvim',
        build = 'conda run --no-capture-output -n jupynium pip install .',
    },
    'rcarriga/nvim-notify',
    'stevearc/dressing.nvim',

    -- UI
    'folke/zen-mode.nvim',
    'm4xshen/smartcolumn.nvim',

    -- Markdown headlines (setup lives in after/plugin/headlines.lua)
    {
        'lukas-reineke/headlines.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
    },

    -- LaTeX
    'lervag/vimtex',
})
