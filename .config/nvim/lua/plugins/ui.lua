return {
    {
        'folke/zen-mode.nvim',
        cmd = { 'ZenMode' },
        opts = {
            window = {
                backdrop = 0.95,
                width = 120,
                height = 1,
                options = {
                    number = false,
                    relativenumber = false,
                    cursorline = false,
                    cursorcolumn = false,
                },
            },
            plugins = {
                options = {
                    enabled = true,
                    ruler = false,
                    showcmd = false,
                    laststatus = 0,
                },
                twilight = { enabled = true },
                gitsigns = { enabled = false },
                tmux = { enabled = false },
                kitty = { enabled = false, font = "+4" },
                alacritty = { enabled = false, font = "14" },
                wezterm = { enabled = false, font = "+6" },
            },
            on_open = function(win) end,
            on_close = function() end,
        },
    },
    {
        'm4xshen/smartcolumn.nvim',
        event = 'BufReadPost',
        opts = {
            colorcolumn = "120",
            disabled_filetypes = { "help", "text", "markdown" },
            custom_colorcolumn = { python = "89" },
            scope = "file",
        },
    },
}
