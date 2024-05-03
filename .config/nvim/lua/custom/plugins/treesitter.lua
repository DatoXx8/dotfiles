return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            -- 'nvim-treesitter/nvim-treesitter-textobjects',
            -- 'nvim-treesitter/nvim-treesitter-context'
            -- 'nvim-treesitter/nvim-treesitter-refactor'
            -- 'nvim-treesitter/nvim-treesitter-docs'
            -- 'nvim-treesitter/playground'
            'nvim-treesitter/completion-treesitter'
        },
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'markdown', 'markdown_inline', 'c', 'lua', 'python', 'rust', 'vimdoc', 'vim' },
                ignore_install = {},
                modules = {},
                sync_install = false,

                auto_install = true,

                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<M-space>',
                    },
                },
            }
        end
    },
}
