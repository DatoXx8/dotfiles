vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll a half page down while keeping the cursor centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll a half page up while keeping the cursor centered' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Move to the next and re-center' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Move to the previous and re-center' })
vim.keymap.set('v', '<leader>a', '<C-a>gvj',
    { desc = 'In visual mode increment the section and go down. Kinda janky but it works' })
vim.keymap.set('n', '<leader>hs', vim.cmd.sp, { desc = 'Split the window horizontally' })
vim.keymap.set('n', '<leader>vs', vim.cmd.vsp, { desc = 'Split the window vertically' })
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move selected text down and automatically re-indent' })
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', { desc = 'Move selected text up and automatically re-indent' })
vim.keymap.set('n', '<leader>rw', vim.cmd.Ex, { desc = 'Open up NetRW' })
vim.keymap.set('v', '<leader>y', '\"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>p', '\"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<C-i>', vim.cmd.w, { desc = 'Save the current file' })
vim.keymap.set('n', '<leader><space>', ":vs<CR>:terminal<CR>i", { desc = 'Open da term' })
vim.keymap.set('t', '<C-a>', '<C-\\><C-n>', { desc = 'Go into normal mode' })
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>:q<CR>', { desc = 'Close da term' })
vim.keymap.set('n', '<C-q>', ':q<CR>', { desc = 'Close da thing' })
vim.o.hlsearch = false
vim.o.mouse = nil
vim.o.expandtab = true
vim.o.showmode = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.wo.number = true
vim.wo.relativenumber = true
-- vim.wo.numberwidth = 5 
vim.o.breakindent = true
vim.o.undofile = true
-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 1000
-- vim.o.guicursor = "n-v-c-sm-i-ci-ve-o-cr-r:block"
vim.g.netrw_sort_sequence =
"[\\/]$,\\<core\\%(\\.\\d\\+\\)\\=\\>,\\~\\=\\*$,*,\\.o$,\\.obj$,\\.info$,\\.swp$,\\.bak$,\\~$"
vim.o.timeoutlen = 250
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.opt.scrolloff = 16
vim.diagnostic.config({ update_on_insert = true })
Cmd = nil
vim.keymap.set('n', '<F2>', function()
    if Cmd ~= nil then
        vim.cmd(Cmd)
    else
        Cmd = vim.fn.input("Your command: ")
        vim.print("Bound command")
    end
end)
vim.keymap.set('n', '<F3>', function()
    Cmd = nil
    vim.print("Removed command")
end)
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
vim.filetype.add({
    extension = {
        cl = 'c'
    }
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
    {
        import = 'custom.plugins'
    },
}, {})

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
}

pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Call LSP formating' })

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = true,
    })
end, { desc = 'Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>sm', require('telescope.builtin').man_pages, { desc = 'Search manual pages' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { desc = 'Code Action' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = 'Goto References' })
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto Implementation' })
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type Definition' })
vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = 'Document Symbols' })
vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    { desc = 'Workspace Symbols' })

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help)

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Workspace Add Folder' })
-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Workspace Remove Folder' })
-- vim.keymap.set('n', '<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, { desc = 'Workspace List Folders' })

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- pyright, rust_analyzer, lua_ls, clangd
require('lspconfig').lua_ls.setup({ capabilities = capabilities })
require('lspconfig').clangd.setup({
    capabilities = capabilities,
    settings = {}
})
require('lspconfig').rust_analyzer.setup({
    capabilities = capabilities,
})
require('lspconfig').pyright.setup({ capabilities = capabilities })
require('lspconfig').zls.setup({
    capabilities = capabilities,
})
