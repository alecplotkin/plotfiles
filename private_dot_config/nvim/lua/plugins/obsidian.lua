local vault = vim.fn.expand("~/notes")

-- Turn a title into a filename-safe slug: "Platform Sync!" -> "platform-sync"
local function slugify(title)
    return (title:lower():gsub("[^%w%s-]", ""):gsub("%s+", "-"))
end

-- Create (or open) meetings/YYYY-MM-DD-<slug>.md from templates/meeting.md
local function new_meeting()
    vim.ui.input({ prompt = "Meeting title: " }, function(title)
        if not title or title == "" then return end
        local date = os.date("%Y-%m-%d")
        local path = string.format("%s/meetings/%s-%s.md", vault, date, slugify(title))
        if vim.fn.filereadable(path) == 0 then
            local lines = vim.fn.readfile(vault .. "/templates/meeting.md")
            for i, line in ipairs(lines) do
                lines[i] = line:gsub("{{title}}", title):gsub("{{date}}", date)
            end
            vim.fn.mkdir(vim.fs.dirname(path), "p")
            vim.fn.writefile(lines, path)
        end
        vim.cmd.edit(path)
    end)
end

return {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    event = {
        'BufReadPre ' .. vault .. '/*.md',
        'BufNewFile ' .. vault .. '/*.md',
    },
    cmd = 'Obsidian',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>ot', '<cmd>Obsidian today<cr>',        desc = 'Notes: today' },
        { '<leader>oy', '<cmd>Obsidian yesterday<cr>',    desc = 'Notes: previous workday' },
        { '<leader>od', '<cmd>Obsidian dailies<cr>',      desc = 'Notes: list dailies' },
        { '<leader>on', '<cmd>Obsidian new<cr>',          desc = 'Notes: new note' },
        { '<leader>of', '<cmd>Obsidian quick_switch<cr>', desc = 'Notes: find note' },
        { '<leader>os', '<cmd>Obsidian search<cr>',       desc = 'Notes: grep vault' },
        { '<leader>om', new_meeting,                      desc = 'Notes: new meeting' },
    },
    opts = {
        legacy_commands = false, -- only `:Obsidian <sub>`, not `:ObsidianToday` etc.
        workspaces = {
            { name = 'notes', path = vault },
        },

        -- New notes from `:Obsidian new` / following a new [[link]] go in notes/
        notes_subdir = 'notes',
        new_notes_location = 'notes_subdir',
        note_id_func = function(title)
            if title and title ~= '' then return slugify(title) end
            return tostring(os.time())
        end,

        daily_notes = {
            folder = 'daily',
            date_format = '%Y-%m-%d',
            alias_format = '%A, %B %-d, %Y',
            default_tags = { 'daily' },
            template = 'daily.md',
            workdays_only = true, -- `yesterday` on Monday opens Friday
        },

        templates = {
            folder = 'templates',
            date_format = '%Y-%m-%d',
            time_format = '%H:%M',
        },

        -- [[link]] and #tag completion comes from obsidian.nvim's built-in LSP,
        -- which nvim-cmp already picks up through its nvim_lsp source.

        picker = { name = 'telescope.nvim' },
    },
}
