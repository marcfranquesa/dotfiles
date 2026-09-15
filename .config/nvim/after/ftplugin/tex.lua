vim.wo.spell = true

local function servername()
    local server = vim.v.servername

    if server == "" then
        server = vim.fn.serverstart()
    end

    return server
end

local function run_open_compiled(args, error_message)
    local command = vim.list_extend({ "open-compiled", vim.fn.expand("%:p") }, args or {})

    local job = vim.fn.jobstart(command, {
        detach = true,
        env = { NVIM_SERVER = servername() },
    })

    if job <= 0 then
        vim.notify(error_message, vim.log.levels.ERROR)
    end
end

local function synctex_jump()
    run_open_compiled({
        tostring(vim.fn.line(".")),
        tostring(vim.fn.col(".")),
    }, "Failed to start SyncTeX forward search")
end

local function open_compiled()
    run_open_compiled(nil, "Failed to open compiled PDF")
end

vim.api.nvim_buf_create_user_command(0, "SynctexJump", synctex_jump, {})
vim.api.nvim_buf_create_user_command(0, "OpenCompiled", open_compiled, {})

vim.keymap.set("n", "<cr>", synctex_jump, { buffer = true, silent = true, desc = "SyncTeX forward search" })
vim.keymap.set("n", "<leader>o", open_compiled, { buffer = true, silent = true, desc = "Open compiled PDF" })
