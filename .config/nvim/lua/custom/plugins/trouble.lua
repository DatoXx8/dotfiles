return {
    "folke/trouble.nvim",
    opts = {
    },
    config = function()
        vim.keymap.set('n', '<leader>t', vim.cmd.TroubleToggle)
    end
}
