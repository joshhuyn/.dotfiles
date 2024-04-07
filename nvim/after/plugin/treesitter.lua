require('nvim-treesitter.configs').setup {
    ensure_installed = { "bash", "c", "html", "css", "javascript", "markdown", "java" },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
}
