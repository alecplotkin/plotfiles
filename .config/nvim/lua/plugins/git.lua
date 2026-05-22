return {
    'tpope/vim-fugitive',
    lazy = false,
    config = function()
        vim.api.nvim_create_user_command('Gitv', function(opts)
            vim.cmd('vertical Git ' .. (opts.args or ''))
        end, {
            nargs = '*',
            complete = 'customlist,fugitive#Complete',
        })
        vim.api.nvim_create_user_command('Ga', function(opts)
            vim.cmd('Git add ' .. (opts.args))
        end, {
            nargs = '+',
            complete = 'customlist,fugitive#Complete',
        })
        vim.api.nvim_create_user_command('Gcmsg', function(opts)
            vim.cmd('Git commit -m ' .. (opts.args or ''))
        end, {
            nargs = '*',
            complete = 'customlist,fugitive#Complete',
        })
    end,
    keys = {
        { '<leader>gs', vim.cmd.Git },
        { '<leader>gsv', ':Gitv<CR>', desc = 'Git (vertical)' },
    },
}
