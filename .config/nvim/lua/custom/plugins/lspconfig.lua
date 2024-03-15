return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'williamboman/mason.nvim',
                config = true
            },

            'folke/neodev.nvim',

            'williamboman/mason-lspconfig.nvim',
        },
    }
}

