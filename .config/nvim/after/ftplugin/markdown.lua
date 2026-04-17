vim.opt_local.spell = true
vim.opt_local.wrap = true
vim.opt_local.breakindent = true
vim.opt_local.linebreak = true
vim.opt_local.showbreak = string.rep(" ", 2)
-- Remap 'j, k' for moving within word wrap 
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
