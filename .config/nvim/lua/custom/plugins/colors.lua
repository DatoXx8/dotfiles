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
    }
}
