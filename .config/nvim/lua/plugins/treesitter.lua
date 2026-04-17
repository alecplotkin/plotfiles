return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
}
