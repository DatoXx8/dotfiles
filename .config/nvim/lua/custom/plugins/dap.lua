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

            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" }
            }

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
            vim.keymap.set('n', '<leader>b', vim.cmd.DapToggleBreakpoint)
            vim.keymap.set('n', '<leader>rp', vim.cmd.DapToggleRepl)
            vim.keymap.set('n', '<F4>', dap.terminate)
            vim.keymap.set('n', '<F5>', dap.continue)
            vim.keymap.set('n', '<F9>', dap.step_over)
            vim.keymap.set('n', '<F11>', dap.step_into)
            vim.keymap.set('n', '<F11>', dap.step_out)
            vim.keymap.set('n', '<F12>', dap.step_back)
            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ' .. vim.fn.getcwd() .. '/')
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }
            dap.configurations.rust = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ' .. vim.fn.getcwd() .. '/')
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }
        end
    }
}
