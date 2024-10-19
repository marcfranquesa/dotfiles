local options = {
    autoindent = true,
    number = true,
    relativenumber = true,
    ignorecase = true, -- case insensitive search
    smartcase = true, -- unless there are capital letters
    cursorline = true,
    scrolloff = 10, -- minimum number of lines above and below the cursor
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    showmode = false,
    wrap = false,

    -- display certain whitespaces differently
    list = true,
    listchars = { tab = "» ", trail = "·", nbsp = "␣" },
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- highlight on yank
vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

-- netrw (:Explore) configuration

-- files not worth seeing
local extensions = {
    "aux",
    "log",
    "bbl",
    "out",
    "blg",
    [[run\.xml]],
    "bcf",
    "snm",
    "nav",
}
for i, value in ipairs(extensions) do
    extensions[i] = [[.*\.]] .. value .. "$"
end

local regexes = {
    [[\./$,\.\./$,\.git/$]],
    [[\.DS_Store$]],
    table.concat(extensions, ","),
    vim.fn["netrw_gitignore#Hide"](),
}
local netrw_hide = table.concat(regexes, ",")

local netrw_options = {
    netrw_list_hide = netrw_hide,
    netrw_hide = 1, -- hide files by default
    netrw_banner = 0, -- hide banner by default
    netrw_browse_split = 0,
}

for k, v in pairs(netrw_options) do
    vim.g[k] = v
end
