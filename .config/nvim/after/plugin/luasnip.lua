local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
    -- Keep last snippet in history. Can jump back even if outside selection.
    history = true,
    -- Use for dynamic snippets, i.e. update while typing.
    updateevents = "TextChanged,TextChangedI",
    -- Autosnippets
    enable_autosnippets = true,
    -- Crazy highlights!!
    -- ext_opts = nil,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<-", "Error" } },
            },
        },
    },
}

-- Setup snippet variables in environment, to be accessed from snippet files.
ls.setup({
	snip_env = {
		s = function(...)
			local snip = ls.s(...)
			-- we can't just access the global `ls_file_snippets`, since it will be
			-- resolved in the environment of the scope in which it was defined.
			table.insert(getfenv(2).ls_file_snippets, snip)
		end,
		parse = function(...)
			local snip = ls.parser.parse_snippet(...)
			table.insert(getfenv(2).ls_file_snippets, snip)
		end,
        -- fmt = function(...)
        --     local snip = require("luasnip.extras.fmt").fmt(...)
        --     table.insert(getfenv(2).ls_file_snippets, snip)
        -- end,
        -- i = function(...)
        --     local snip = ls.insert_node(...)
        --     table.insert(getfenv(2).ls_file_snippets, snip)
        -- end,
        -- rep = function(...)
        --     local snip = require("luasnip.extras").rep(...)
        --     table.insert(getfenv(2).ls_file_snippets, snip)
        -- end,
		-- remaining definitions.
		...
	},
	...
})

-- Require snippet files.
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})

-- Keymaps
-- Jump forward
vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

-- Jump backward
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- Select from list of options, useful for choice nodes.
vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })
