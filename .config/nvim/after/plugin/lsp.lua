-- Mason: manages server binary installation
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'pylsp', 'jedi_language_server', 'lua_ls', 'r_language_server' }
})

-- Capabilities: advertise nvim-cmp completion to all servers
local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)

-- Global defaults (applies to every server)
vim.lsp.config('*', { capabilities = capabilities })

vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', 'stylua.toml', '.git' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = { checkThirdParty = false },
            diagnostics = { globals = { 'vim' } },
            telemetry = { enable = false },
        }
    }
})

vim.lsp.config('jedi_language_server', {
    cmd = { 'jedi-language-server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', '.git' },
})

vim.lsp.config('pylsp', {
    cmd = { 'pylsp' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', '.git' },
})

vim.lsp.config('r_language_server', {
    filetypes = { 'r', 'rmd' },
    root_markers = { 'DESCRIPTION', '.Rproj', '.git' },
})

-- Activate servers (start when a matching filetype is opened)
vim.lsp.enable({ 'pylsp', 'jedi_language_server', 'lua_ls', 'r_language_server' })

-- Keymaps on attach
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local opts = { buffer = ev.buf, remap = false }
        vim.keymap.set("n", "<leader>gd",  vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K",           vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd",  vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d",          vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "]d",          vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<C-h>",       vim.lsp.buf.signature_help, opts)
    end
})

-- Disable sign column icons
vim.diagnostic.config({ signs = false })

-- nvim-cmp completion setup
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>']     = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>']     = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>']     = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }),
})
