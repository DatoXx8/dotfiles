vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll a half page down while keeping the cursor centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll a half page up while keeping the cursor centered' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll a half page down while keeping the cursor centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll a half page up while keeping the cursor centered' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Move to the next and re-center'})
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Move to the previous and re-center'})
vim.keymap.set('v', '<leader>a', '<C-a>gvj', { desc = 'In visual mode increment the section and go down. Kinda janky but it works' })
vim.keymap.set('n', '<leader>hs', vim.cmd.sp, { desc = 'Split the window horizontally' })
vim.keymap.set('n', '<leader>vs', vim.cmd.vsp, { desc = 'Split the window vertically' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to the split on the left'})
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to the split on the bottom'})
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to the split on the top'})
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to the split on the right'})
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move selected text down and automatically re-indent'})
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', { desc = 'Move selected text up and automatically re-indent'})
vim.keymap.set('n', '<leader>rw', vim.cmd.Ex, { desc = 'Open up NetRW' })
vim.keymap.set('v', '<leader>y', '\"+y', { desc = 'Yank to system clipboard'})
vim.keymap.set('n', '<leader>p', '\"+p', { desc = 'Paste from system clipboard'})
vim.o.hlsearch = false
vim.o.mouse = nil
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.breakindent = true
vim.o.undofile = true
-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 100
vim.o.timeoutlen = 250
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.opt.scrolloff = 10
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
-- Remaps for dealing with word wrap
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- Turn off word wrap
-- vim.o.nowrap = true
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

if not vim.g.vscode then -- I have to use vscode for opencl :^(
    -- Install package manager
    --        https://github.com/folke/lazy.nvim
    --        `:help lazy.nvim.txt` for more info
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

    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end, { desc = 'Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>sgf', require('telescope.builtin').git_files, { desc = 'Search Git Files' })
    vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Search Files' })
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
    vim.keymap.set('n', '<leader>sgr', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })

    vim.keymap.set('n', '<C-i>', vim.cmd.w, { desc = 'Save the current file' })


    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

    -- [[ Configure LSP ]]
    --    This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
        nmap('<leader>a', vim.lsp.buf.code_action, 'Code Action')

        nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
        nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
        nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr })

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
        nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'Workspace List Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
    end

    -- Enable the following language servers
    --    Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --    Add any additional override configuration in the following tables. They will be passed to
    --    the `settings` field of the server config. You must look up that documentation yourself.
    --
    --    If you want to override the default filetypes that your language server will attach to you can
    --    define the property 'filetypes' to the map in question.
    local servers = {
        clangd = {},
        pyright = {},
        opencl_ls = {},
        rust_analyzer = {},
        lua_ls = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
    }

    require('neodev').setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
        function(server_name)
            require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
                filetypes = (servers[server_name] or {}).filetypes,
            }
        end,
    }

end
