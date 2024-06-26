return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                styles = {
                    bold = false,
                    italic = true,
                    transparency = false,
                },
            })
            vim.cmd('colorscheme rose-pine')
        end,
    },
    -- {
    --     'Mofiqul/vscode.nvim'
    -- },
    -- {
    --     'ellisonleao/gruvbox.nvim',
    --     config = function()
    --         vim.cmd('colorscheme gruvbox')
    --     end,
    -- },
    -- {
    --      'folke/tokyonight.nvim'
    -- },
    -- {
    --     'maxmx03/dracula.nvim',
    --     config = function()
    --         vim.cmd('colorscheme dracula')
    --     end,
    -- },
    -- {
    --     'maxmx03/solarized.nvim'
    -- }
}
