vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll a half page down while keeping the cursor centered' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll a half page up while keeping the cursor centered' })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll a half page down while keeping the cursor centered' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll a half page up while keeping the cursor centered' })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<leader>a", "<C-a>gvj", { desc = "In visual mode increment the section and go down. Kinda janky but it works"})
vim.keymap.set("n", "<leader>hs", vim.cmd.sp, { desc = 'Split the window horizontally' })
vim.keymap.set("n", "<leader>vs", vim.cmd.vsp, { desc = 'Split the window vertically' })

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("v", "J", ":m '>+1<CR>gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv")

vim.opt.scrolloff = 10

if vim.g.neovide then
    vim.g.neovide_refresh_rate = 144
    vim.g.neovide_refresh_rate_idle = 1
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_cursor_antialiasing = true
end

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

if not vim.g.vscode then -- I have to use vscode for opencl :^(
    require('lazy').setup({

        {
            "NeogitOrg/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim",

                "nvim-telescope/telescope.nvim",
            },
            config = true,
            vim.keymap.set('n', '<leader>g', vim.cmd.Neogit),
        },

        {
            'neovim/nvim-lspconfig',
            dependencies = {
                {'williamboman/mason.nvim',
                    config = true
                },

                'folke/neodev.nvim',

                'williamboman/mason-lspconfig.nvim',
            },
        },
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',

                'hrsh7th/cmp-nvim-lsp',

                -- 'rafamadriz/friendly-snippets',
            },
        },

        -- {
        --     'nvim-lualine/lualine.nvim',
        --     opts = {
        --         options = {
        --             icons_enabled = false,
        --             component_separators = '|',
        --             section_separators = '',
        --         },
        --     },
        -- },


        { 'numToStr/Comment.nvim', opts = {} },

        {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            dependencies = {
                'nvim-lua/plenary.nvim',
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    build = 'make',
                    cond = function()
                        return vim.fn.executable 'make' == 1
                    end,
                },
            },
        },

        {
            'nvim-treesitter/nvim-treesitter',
            dependencies = {
                -- 'nvim-treesitter/nvim-treesitter-textobjects',
            },
            build = ':TSUpdate',
        },

        require 'kickstart.plugins.debug',

        { import = 'custom.plugins' },
    }, {})

    vim.o.hlsearch = false

    vim.o.mouse = nil

    vim.o.expandtab = true
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4

    vim.wo.number = true
    vim.wo.relativenumber = true

    -- Sync clipboard between OS and Neovim.
    --    Remove this option if you want your OS clipboard to remain independent.
    --    See `:help 'clipboard'`
    vim.o.clipboard = 'unnamedplus'

    vim.o.breakindent = true

    vim.o.undofile = true

    -- Case-insensitive searching UNLESS \C or capital in search
    vim.o.ignorecase = true
    -- vim.o.smartcase = true

    vim.wo.signcolumn = 'yes'

    vim.o.updatetime = 100
    vim.o.timeoutlen = 250

    vim.o.completeopt = 'menuone,noselect'

    vim.o.termguicolors = true

    vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

    -- Remaps for dealing with word wrap
    -- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    -- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
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

    require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { "markdown", "markdown_inline", 'c', 'lua', 'python', 'rust', 'vimdoc', 'vim' },
        ignore_install = {},
        modules = {},

        auto_install = true,

        highlight = {
            enable = true,
            -- additional_vim_regex_highlighting = { "markdown" },
        },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<c-space>',
                node_incremental = '<c-space>',
                scope_incremental = '<c-s>',
                node_decremental = '<M-space>',
            },
        },
        -- textobjects = {
        --     select = {
        --         enable = true,
        --         lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        --         keymaps = {
        --             -- You can use the capture groups defined in textobjects.scm
        --             ['aa'] = '@parameter.outer',
        --             ['ia'] = '@parameter.inner',
        --             ['af'] = '@function.outer',
        --             ['if'] = '@function.inner',
        --             ['ac'] = '@class.outer',
        --             ['ic'] = '@class.inner',
        --         },
        --     },
        --     move = {
        --         enable = true,
        --         set_jumps = true, -- whether to set jumps in the jumplist
        --         goto_next_start = {
        --             [']m'] = '@function.outer',
        --             [']]'] = '@class.outer',
        --         },
        --         goto_next_end = {
        --             [']M'] = '@function.outer',
        --             [']['] = '@class.outer',
        --         },
        --         goto_previous_start = {
        --             ['[m'] = '@function.outer',
        --             ['[['] = '@class.outer',
        --         },
        --         goto_previous_end = {
        --             ['[M'] = '@function.outer',
        --             ['[]'] = '@class.outer',
        --         },
        --     },
        --     swap = {
        --         enable = true,
        --         swap_next = {
        --             ['<leader>a'] = '@parameter.inner',
        --         },
        --         swap_previous = {
        --             ['<leader>A'] = '@parameter.inner',
        --         },
        --     },
        -- },
    }

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
        nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

        nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
        nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
        nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
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
        -- gopls = {},
        pyright = {},
        opencl_ls = {
        },
        rust_analyzer = {},
        -- tsserver = {},
        -- html = { filetypes = { 'html', 'twig', 'hbs'} },

        lua_ls = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
    }

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
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

    -- [[ Configure nvim-cmp ]]
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert {
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-y>'] = cmp.mapping.confirm {
                select = true,
            },
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },
    }

    vim.keymap.set("n", "<leader>rw", vim.cmd.Ex, { desc = 'Open up NetRW' })
    -- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    -- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


    vim.diagnostic.config({ update_on_insert = true })

    require("rose-pine").setup({
        styles = {
            bold = false,
            italic = true,
            transparency = false,
        },
    })
    vim.cmd("colorscheme rose-pine")
end
