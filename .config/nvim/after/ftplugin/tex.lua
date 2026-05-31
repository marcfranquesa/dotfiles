vim.wo.spell = true

local function synctex_jump()
    local line = vim.fn.line(".")
    local column = vim.fn.col(".")
    local file = vim.fn.expand("%:p")
    local server = vim.v.servername

    if server == "" then
        server = vim.fn.serverstart()
    end

    local job = vim.fn.jobstart({ "open-compiled", file, tostring(line), tostring(column) }, {
        detach = true,
        env = { NVIM_SERVER = server },
    })

    if job <= 0 then
        vim.notify("Failed to start SyncTeX forward search", vim.log.levels.ERROR)
    end
end

local function open_compiled()
    local file = vim.fn.expand("%:p")
    local server = vim.v.servername

    if server == "" then
        server = vim.fn.serverstart()
    end

    local job = vim.fn.jobstart({ "open-compiled", file }, {
        detach = true,
        env = { NVIM_SERVER = server },
    })

    if job <= 0 then
        vim.notify("Failed to open compiled PDF", vim.log.levels.ERROR)
    end
end

vim.api.nvim_buf_create_user_command(0, "SynctexJump", synctex_jump, {})
vim.api.nvim_buf_create_user_command(0, "OpenCompiled", open_compiled, {})

vim.keymap.set("n", "<cr>", synctex_jump, { buffer = true, silent = true, desc = "SyncTeX forward search" })
vim.keymap.set("n", "<leader>o", open_compiled, { buffer = true, silent = true, desc = "Open compiled PDF" })
