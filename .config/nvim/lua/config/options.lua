local options = {
    autoindent = true,
    number = true,
    relativenumber = true,
    ignorecase = true, -- case insensitive search
    smartcase = true, -- unless there are capital letters
    cursorline = true,
    scrolloff = 10,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    showmode = false,
    wrap = false,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

