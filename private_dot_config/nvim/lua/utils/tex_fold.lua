local M = {}

local function tprint(tbl)
    local result = {}
    for k, v in pairs(tbl) do
        table.insert(result, v)
    end
    return table.concat(result, ", ")
end

function M.scan_for_new_environments()
    local new_envs = {}
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        local env_name = line:match("\\newenvironment{(%w+)}")
        if env_name then
            table.insert(new_envs, env_name)
        end
    end
    return new_envs
end

function M.update_fold_types()
    if vim.bo.filetype ~= "tex" then
        print("This function is only for LaTeX files.")
        return
    end
    local custom_envs = M.scan_for_new_environments()
    local current_whitelist = vim.g.vimtex_fold_types.envs.whitelist or {}
    vim.g.vimtex_fold_types.envs.whitelist = vim.list_extend(
        current_whitelist, custom_envs
    )
    print("Fold types updated with custom environments: " .. tprint(custom_envs))
end

return M
