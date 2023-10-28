-- yank to system clipboard
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- disable search highlights of *previous* search
vim.opt.hlsearch = false
vim.opt.expandtab = true

-- Tab width
vim.opt.tabstop = 4
-- Indentation width
vim.opt.shiftwidth = 4

vim.g.mapleader = ' '
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")

-- Init plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    "morhetz/gruvbox",

    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",

    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",

    "kyazdani42/nvim-tree.lua",
    "nvim-treesitter/nvim-treesitter",

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" }
    }
})

-- Set theme and support more than 256 colors
vim.opt.termguicolors = true
vim.cmd.colorscheme("gruvbox")

-- Setup nvim-tree
require("nvim-tree").setup({})

vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<cr>")

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local options = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, options)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, options)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, options)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, options)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, options)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, options)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, options)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, options)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, options)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, options)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, options)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, options)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, options)
    end,
})

-- lspconfig
local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

local cmp = require("cmp")
local select_options = { behavior = cmp.SelectBehavior.Select }

-- Snippets
require("luasnip.loaders.from_vscode").lazy_load()
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        { name = "path" }, -- autocomplete file paths
        { name = "nvim_lsp" }
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(select_options),
        ["<C-n>"] = cmp.mapping.select_next_item(select_options),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort,
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ['<C-f>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-b>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),

    }
})

-- annouce additional features we get from nvim-cmp to LSP servers
lsp_defaults.capabilities = vim.tbl_deep_extend(
    "force",
    lsp_defaults.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
)

lspconfig.clangd.setup({})
lspconfig.sourcekit.setup({})
lspconfig.lua_ls.setup({
    on_init = function(client)
        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                },
                runtime = {
                    version = "LuaJIT"
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                }
            }
        })

        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        return true
    end
})

-- tree-sitter
vim.cmd("syntax off")
require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "lua", "swift", "bash", "vim", "vimdoc" },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true
    }
})

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
