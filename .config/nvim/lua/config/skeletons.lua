local skeletons_group = vim.api.nvim_create_augroup("SkeletonsGroup", { clear = true })

local config_dir = os.getenv("XDG_CONFIG_HOME") or "~/.config"
local skeletons_dir = config_dir .. "/nvim/skeletons"

local function set_up_skeleton(pattern, skeleton, line, column)
    vim.api.nvim_create_autocmd({ "BufNewFile" }, {
        group = skeletons_group,
        pattern = pattern,
        callback = function()
            vim.cmd("0r " .. skeletons_dir .. "/" .. skeleton .. ".skeleton")
            vim.cmd("call cursor(" .. line .. ", " .. column .. ")")
        end,
    })
end

set_up_skeleton("*.tex", "latex", 29, 1)

set_up_skeleton("*.py", "python", 2, 5)
set_up_skeleton("pyproject.toml", "pyproject", 1, 1)
