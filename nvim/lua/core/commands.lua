vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd 'bel 10new'
    local buf = vim.api.nvim_get_current_buf()
    for name, value in pairs {
        filetype = 'scratch',
        buftype = 'nofile',
        bufhidden = 'hide',
        swapfile = false,
        modifiable = true,
    } do
        vim.api.nvim_set_option_value(name, value, { buf = buf })
    end
end, { desc = 'Open a scratch buffer', nargs = 0 })

---@type uv_tcp_t?
local notify_server = nil
vim.api.nvim_create_user_command("StartNotifyServer", function()
    if notify_server and not notify_server:is_closing() then
        return
    end

    local try_notify_server, err = require("notify_server").start_server()
    if err then
        error(err)
    end
    notify_server = try_notify_server
end, {})

vim.api.nvim_create_user_command("StopNotifyServer", function()
    if notify_server and not notify_server:is_closing() then
        notify_server:close()
        vim.notify("Notify server stopped")
    else
        vim.notify("Notify server not running")
    end
end, {})

vim.api.nvim_create_user_command(
    'OpenPlan',
    function()
        vim.cmd('edit ~/.pcheng.plan')
    end,
    { nargs = 0 }
)
vim.api.nvim_set_keymap('n', '<leader>op', ':OpenPlan<CR>', { noremap = true, silent = true })
