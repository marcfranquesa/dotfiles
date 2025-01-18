local options = {
    autoindent = true,
    smartindent = true,
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
    -- wrap = false,

    -- display certain whitespaces differently
    list = true,
    listchars = { tab = "» ", trail = "·", nbsp = "␣" },
}

for k, v in pairs(options) do
    vim.opt[k] = v
end


local globals = {
    tex_flavor = "latex",
}

for k, v in pairs(globals) do
    vim.g[k] = v
end
