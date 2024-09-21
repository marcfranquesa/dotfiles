local options = {
  autoindent = true,
  number = true,
  relativenumber = true,
  ignorecase = true, -- case insensitive search
  smartcase = true, -- unless there are capital letters
  cursorline = true,
  scrolloff = 10,

}
  
for k, v in pairs(options) do
  vim.opt[k] = v
end
