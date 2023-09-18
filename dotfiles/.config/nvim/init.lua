-- yank to system clipboard
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.completeopt = { "menu", "preview", "noinsert" , "noselect" }
-- disable search highlights of *previous* search
vim.opt.hlsearch = false
vim.opt.expandtab = true

-- Tab width
vim.opt.tabstop = 4
-- Indentation width
vim.opt.shiftwidth = 4

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')

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
    "morhetz/gruvbox"
})

-- Set theme and support more than 256 colors
vim.opt.termguicolors = true
vim.cmd.colorscheme("gruvbox")

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
    pattern="swift",
    callback = function()
	local root_dir = vim.fs.dirname(
	    vim.fs.find({ 'Package.swift' }, { upward = true })[1]
	)
	local client = vim.lsp.start({
	    name = 'SourceKit-LSP',
	    cmd = { 'sourcekit-lsp' },
	    root_dir = root_dir
	})
	vim.lsp.buf_attach_client(0, client)
    end
})

