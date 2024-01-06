local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
    cmd = { "clangd", "--background-index", "--clang-tidy" }
})

lspconfig.sourcekit.setup({
    filetypes = { "swift" }
})
lspconfig.pylsp.setup({})
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
