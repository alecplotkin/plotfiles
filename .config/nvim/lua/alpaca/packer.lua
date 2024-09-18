-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Color schemes
    use "rebelot/kanagawa.nvim"

    -- Syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use('nvim-treesitter/playground')

    -- Snippets
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })

    -- File switching
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    -- Language servers
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }
    use {'snakemake/snakemake', rtp='misc/vim', ft='snakemake'}
    use('snakemake/snakefmt')

    -- Debugging
    use('mfussenegger/nvim-dap')

    -- Install jupynium and dependencies, for working with jupyter notebooks.
    -- use { "kiyoon/jupynium.nvim", run = "pip3 install --user ." }
    use { "kiyoon/jupynium.nvim", run = "conda run --no-capture-output -n jupynium pip install ." }
    use { "rcarriga/nvim-notify" }   -- optional
    use { "stevearc/dressing.nvim" } -- optional, UI for :JupyniumKernelSelect
    -- use {
        --     'chipsenkbeil/distant.nvim',
        --     branch = 'v0.3',
        --     config = function()
            --         require('distant'):setup()
            --     end
            -- }

    -- ZenMode, for focused writing/coding.
    use "folke/zen-mode.nvim"
    use "m4xshen/smartcolumn.nvim"
    use {
        "lukas-reineke/headlines.nvim",
        after = "nvim-treesitter",
        config = function()
            require("headlines").setup()
        end,
    }


    end
)
