vim.cmd("syntax off")
require("nvim-treesitter.configs").setup({
    ensure_installed = { "javascript", "typescript", "c", "cpp", "lua", "swift", "bash", "vim", "vimdoc", "python" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true
    }
})

