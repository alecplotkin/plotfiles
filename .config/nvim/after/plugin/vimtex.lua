-- This is necessary for VimTeX to load properly. The "indent" is optional.
-- Note: Most plugin managers will do this automatically!
-- filetype plugin indent on

-- This enables Vim's and neovim's syntax-related features. Without this, some
-- VimTeX features will not work (see ":help vimtex-requirements" for more
-- info).
-- Note: Most plugin managers will do this automatically!

-- Viewer options: One may configure the viewer either by specifying a built-in
-- viewer method:
vim.g.vimtex_view_method = 'zathura'

-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
-- strongly recommended, you probably don't need to configure anything. If you
-- want another compiler backend, you can change it as follows. The list of
-- supported backends and further explanation is provided in the documentation,
-- see ":help vimtex-compiler".
vim.g.vimtex_compiler_method = 'latexmk'

-- Most VimTeX mappings rely on localleader and this can be changed with the
-- following line. The default is usually fine and is the symbol "\".
vim.g.maplocalleader = ","

-- Set up folding options
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
    -- cmd_multi = {
    --     cmds = {'\\begin{document}', '\\end{document}'},
    -- },
    markers = {
        open = '\\begin{',
        close = '\\end{',
    },
}
