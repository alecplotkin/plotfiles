return {
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        -- Lazy loading is not recommended for oil.nvim (tricky edge cases)
        lazy = false,
        dependencies = { { 'echasnovski/mini.icons', opts = {} } },
        config = function()
            require('oil').setup({
                columns = {
                    { "mtime", format = "%Y-%m-%d\t%H:%M:%S\t" },
                    "icon",
                    -- "permissions",
                    -- "size",
                }
            })
            vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)
        end,
    },
    -- -- Highlight git status of files. Disabled because it slows down oil.nvim
    -- -- significantly.
    -- {
    --     "benomahony/oil-git.nvim",
    --     dependencies = { "stevearc/oil.nvim" },
    --     -- No opts or config needed! Works automatically
    --     config = function()
    --         require("oil-git").setup({
    --             highlights = {
    --                 OilGitAdded = { fg = "#a6e3a1" },     -- green
    --                 OilGitModified = { fg = "#f9e2af" },  -- yellow  
    --                 OilGitRenamed = { fg = "#cba6f7" },   -- purple
    --                 OilGitUntracked = { fg = "#89b4fa" }, -- blue
    --                 OilGitIgnored = { fg = "#6c7086" },   -- gray
    --             }
    --         })
    --     end
    -- }
}
