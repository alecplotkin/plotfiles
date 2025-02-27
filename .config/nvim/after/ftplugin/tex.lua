vim.opt.spell = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.showbreak = string.rep(" ", 2)
--
-- Remap 'j, k' for moving within word wrap 
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Folding
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "vimtex#fold#level(v:lnum)"
-- vim.opt_local.foldexpr = "v:lua.require('utils.tex_fold').foldexpr(v:lnum)"
vim.opt_local.foldtext = "vimtex#fold#text()"
vim.api.nvim_create_user_command('UpdateFoldTypes', function()
    require('utils.tex_fold').update_fold_types()
end, {})

-- local tex_fold = require('utils.tex_fold')
-- tex_fold.update_fold_types()
