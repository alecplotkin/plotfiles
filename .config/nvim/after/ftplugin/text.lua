vim.opt_local.spell = true
vim.opt_local.wrap = true
vim.opt_local.breakindent = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 0
vim.opt_local.showbreak = string.rep(" ", 2)

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
