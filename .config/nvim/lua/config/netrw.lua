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
    [[synctex\.gz]],
    "pdf",
    "toc",
}
for i, value in ipairs(extensions) do
    extensions[i] = [[.*\.]] .. value .. "$"
end

local regexes = {
    [[\./$,\.\./$,\.git/$]],
    [[\.DS_Store$]],
    [[\.venv/$]],
    [[venv/$]],
    [[svg-inkscape/$]],
    table.concat(extensions, ","),
    vim.fn["netrw_gitignore#Hide"](),
}
local netrw_hide = table.concat(regexes, ",")

local netrw_options = {
    netrw_list_hide = netrw_hide,
    netrw_hide = 1, -- hide files by default, toggle with `a`
    netrw_banner = 0, -- hide banner by default, toggle with `I`
    netrw_browse_split = 0, -- opening of file
    netrw_liststyle = 0, -- toggle with `i`
}

for k, v in pairs(netrw_options) do
    vim.g[k] = v
end
