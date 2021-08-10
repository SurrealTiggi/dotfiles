return function()
  require "nvim-treesitter.configs".setup {
    ensure_installed = {
      "bash",
      "comment",
      "css",
      "go",
      "graphql",
      "html",
      "javascript",
      "typescript",
      "jsdoc",
      "json",
      "lua",
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
end
