return {
    {
        'theprimeagen/harpoon',
        keys = {
            { '<leader>a', function() require('harpoon.mark').add_file() end },
            { '<C-e>',     function() require('harpoon.ui').toggle_quick_menu() end },
            { '<M-u>',     function() require('harpoon.ui').nav_file(1) end },
            { '<M-i>',     function() require('harpoon.ui').nav_file(2) end },
            { '<M-o>',     function() require('harpoon.ui').nav_file(3) end },
            { '<M-p>',     function() require('harpoon.ui').nav_file(4) end },
        },
    },
    {
        'mbbill/undotree',
        keys = {
            { '<leader>u', vim.cmd.UndotreeToggle },
        },
    },
}
