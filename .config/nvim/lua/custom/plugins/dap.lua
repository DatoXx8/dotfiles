return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio'
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup()


            vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
            vim.keymap.set('n', '<leader>rb', dap.run_to_cursor)
            vim.keymap.set('n', '<F4>', function()
                dap.terminate()
                dapui.close()
            end)
            vim.keymap.set('n', '<F5>', dap.continue)
            vim.keymap.set('n', '<F9>', dap.step_over)
            vim.keymap.set('n', '<F10>', dap.step_into)
            vim.keymap.set('n', '<F11>', dap.step_out)
            vim.keymap.set('n', '<F12>', dap.step_back)
            vim.keymap.set('n', '<F13>', dap.restart)
            Args = nil
            vim.keymap.set('n', '<F14>', function()
                if not Args then
                    Args = vim.fn.input('Arguments for DAP program: ')
                end
            end)
            vim.keymap.set('n', '<S-F3>', function()
                Args = nil
            end)
            vim.keymap.set('n', '<leader>?', function() dapui.eval(nil, { enter = true }) end)

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" , Args}
            }
            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ' .. vim.fn.getcwd() .. '/')
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = true,
                    args = function ()
                       return { Args }
                    end,
                },
            }
        end
    }
}
