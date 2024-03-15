return {
    -- { 'echasnovski/mini.completion', version = false },
    -- require('mini.completion').setup({
    --     delay = { completion = 0, info = 0, signature = 0 },
    --     window = {
    --         info = { height = 25, width = 80, border = 'none' },
    --         signature = { height = 25, width = 80, border = 'none' },
    --     },
    --     lsp_completion = {
    --         source_func = 'completefunc',
    --         auto_setup = true,
    --     },
    --     set_vim_settings = true,
    -- })
    {
        'echasnovski/mini.surround',
        version = false,
        config = function()
            require('mini.surround').setup({
                highlight_duration = 1000,
            })
        end
    },
}
