return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = false, -- show icons in the signs column
        keywords = {
            FIX = {
                icon = " ", -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "hack" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
            fg = "NONE",              -- The gui style to use for the fg highlight group.
            bg = "NONE",              -- The gui style to use for the bg highlight group.
        },
        merge_keywords = true,        -- when true, custom keywords will be merged with the defaults
        highlight = {
            multiline = false,         -- enable multine todo comments
            before = "empty",            -- "fg" or "bg" or empty
            keyword = "fg",           -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
            after = "empty",             -- "fg" or "bg" or empty
            comments_only = true,     -- uses treesitter to match keywords in comments only
            max_line_len = 400,       -- ignore lines longer than this
        },
        colors = {
            hack = {"Function"},
        }
    }
}
