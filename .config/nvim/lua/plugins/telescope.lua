return {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
        -- Shim for ft_to_lang removed in Neovim 0.12; telescope 0.1.x still calls it
        if not vim.treesitter.language.ft_to_lang then
            vim.treesitter.language.ft_to_lang = function(ft) return ft end
        end
    end,
    keys = {
        { '<leader>pf', function() require('telescope.builtin').find_files() end },
        { '<leader>pg', function() require('telescope.builtin').git_files() end },
        { '<leader>ps', function()
            require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
        end },
    },
}
