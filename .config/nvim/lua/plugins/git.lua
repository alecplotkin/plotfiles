return {
    'tpope/vim-fugitive',
    keys = {
        { '<leader>gs', vim.cmd.Git },
        { '<leader>gsv', ':VG<CR>', desc = 'Git (vertical)' },
    },
    config = function()
        vim.api.nvim_create_user_command('VG', 'vertical Git', {})
    end
}
