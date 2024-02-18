return {
    "folke/zen-mode.nvim",
    opts = {
        plugins = {
            options = {
                enabled = true,
            },
            tmux = {
                enabled = true,
            },
        },
    },
    vim.keymap.set('n', '<leader>z', vim.cmd.ZenMode, {desc = 'Toggle ZenMode'}),
}
