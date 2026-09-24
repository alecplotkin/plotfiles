vim.opt_local.spell = true
vim.opt_local.wrap = true
vim.opt_local.breakindent = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 0
vim.opt_local.showbreak = string.rep(" ", 2)
-- Let obsidian.nvim conceal link syntax and render checkboxes
vim.opt_local.conceallevel = 2
-- Remap 'j, k' for moving within word wrap 
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Checkboxes: toggle `- [ ]` <-> `- [x]`; turns a plain `- item` into `- [ ] item`
local function toggle_checkbox(l1, l2)
    for lnum = l1, l2 do
        local line = vim.fn.getline(lnum)
        local new
        if line:match("^%s*[-*+] %[ %]") then
            new = line:gsub("%[ %]", "[x]", 1)
        elseif line:match("^%s*[-*+] %[.%]") then
            new = line:gsub("%[.%]", "[ ]", 1)
        elseif line:match("^%s*[-*+] ") then
            new = line:gsub("^(%s*[-*+] )", "%1[ ] ", 1)
        end
        if new then vim.fn.setline(lnum, new) end
    end
end

vim.keymap.set('n', '<leader>x', function()
    local l = vim.fn.line('.')
    toggle_checkbox(l, l)
end, { buffer = true, silent = true, desc = 'Toggle checkbox' })
vim.keymap.set('x', '<leader>x', function()
    local a, b = vim.fn.line('v'), vim.fn.line('.')
    if a > b then a, b = b, a end
    toggle_checkbox(a, b)
    vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'n', false)
end, { buffer = true, silent = true, desc = 'Toggle checkboxes in selection' })
