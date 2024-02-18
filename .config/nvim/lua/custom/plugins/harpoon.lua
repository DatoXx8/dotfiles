return {
    'ThePrimeagen/harpoon',
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>ha", mark.add_file, {desc = 'Add current file to Harpoon'})
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, {desc = 'Toggle the Harpoon menu'})
        vim.keymap.set("n", "<C-a>", function() ui.nav_file(1) end, { desc = 'Navigate to 1st file' })
        vim.keymap.set("n", "<C-s>", function() ui.nav_file(2) end, { desc = 'Navigate to 2nd file' })
        vim.keymap.set("n", "<C-y>", function() ui.nav_file(3) end, { desc = 'Navigate to 3rd file' })
        vim.keymap.set("n", "<C-x>", function() ui.nav_file(4) end, { desc = 'Navigate to 4th file' })
    end,
}
