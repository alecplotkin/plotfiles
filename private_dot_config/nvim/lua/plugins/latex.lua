return {
    'lervag/vimtex',
    ft = { 'tex', 'latex' },
    init = function()
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_compiler_method = 'latexmk'

        vim.g.vimtex_fold_enabled = 1
        vim.g.vimtex_fold_levelpart = 1

        vim.g.vimtex_fold_types = {
            cmd_single = {
                cmds = {
                    'section',
                    'subsection',
                    'subsubsection',
                    'paragraph',
                    'subparagraph',
                },
            },
            envs = {
                blacklist = {},
                whitelist = {
                    'document',
                    'abstract',
                    'table',
                    'tabular',
                    'figure',
                    'align',
                    'equation',
                    'enumerate',
                },
            },
            markers = {
                open = '\\begin{',
                close = '\\end{',
            },
        }
    end,
}

