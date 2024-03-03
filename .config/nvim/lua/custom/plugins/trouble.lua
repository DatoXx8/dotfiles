return {
    "folke/trouble.nvim",
    opts = {
        icons = false
    },
    config = function()
        vim.keymap.set('n', '<leader>t', vim.cmd.TroubleToggle)
    end
}
