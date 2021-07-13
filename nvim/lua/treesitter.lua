require "nvim-treesitter.configs".setup {
  ensure_installed = {
    "bash",
    "css",
    "go",
    "graphql",
    "html",
    "javascript",
    "typescript",
    "jsdoc",
    "json",
    "python",
    "regex",
    "rust",
    "toml",
    "vue",
    "yaml",
  },
  highlight = {
    enable = true
  }
}
