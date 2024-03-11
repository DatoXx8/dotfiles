return {
    "folke/trouble.nvim",
    config = {
        icons = false,
        vim.keymap.set('n', '<leader>t', vim.cmd.TroubleToggle)
    },
}
