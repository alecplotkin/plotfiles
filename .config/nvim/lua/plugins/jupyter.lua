return {
    {
        'kiyoon/jupynium.nvim',
        build = 'conda run --no-capture-output -n jupynium pip install .',
        event = { 'BufReadPre *.ju.*', 'BufNewFile *.ju.*' },
        dependencies = {
            'rcarriga/nvim-notify',
            'stevearc/dressing.nvim',
        },
        config = function()
            require("jupynium").setup({
                python_host = { "conda", "run", "--no-capture-output", "-n", "jupynium", "python" },

                default_notebook_URL = "localhost:8888/nbclassic",

                jupyter_command = "jupyter",

                notebook_dir = nil,

                firefox_profiles_ini_path = nil,
                firefox_profile_name = nil,

                auto_start_server = {
                    enable = false,
                    file_pattern = { "*.ju.*" },
                },

                auto_attach_to_server = {
                    enable = true,
                    file_pattern = { "*.ju.*", "*.md" },
                },

                auto_start_sync = {
                    enable = false,
                    file_pattern = { "*.ju.*", "*.md" },
                },

                auto_download_ipynb = true,
                auto_close_tab = true,

                autoscroll = {
                    enable = true,
                    mode = "always",
                    cell = {
                        top_margin_percent = 20,
                    },
                },

                scroll = {
                    page = { step = 0.5 },
                    cell = {
                        top_margin_percent = 20,
                    },
                },

                jupynium_file_pattern = { "*.ju.*" },

                use_default_keybindings = true,
                textobjects = {
                    use_default_keybindings = true,
                },

                syntax_highlight = {
                    enable = true,
                },

                shortsighted = false,

                kernel_hover = {
                    floating_win_opts = {
                        max_width = 84,
                        border = "none",
                    },
                },
            })

            vim.cmd [[
hi! link JupyniumCodeCellSeparator CursorLine
hi! link JupyniumMarkdownCellSeparator CursorLine
hi! link JupyniumMarkdownCellContent CursorLine
hi! link JupyniumMagicCommand Keyword
]]
        end,
    },
}
