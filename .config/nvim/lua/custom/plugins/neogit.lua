return {
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',

            'nvim-telescope/telescope.nvim',
        },
        config = true,
        opts = {
        },
        vim.keymap.set('n', '<leader>g', function ()
            require('neogit').open({ kind = 'replace' })
        end),
    },
}
