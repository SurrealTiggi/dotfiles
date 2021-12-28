return function()
  require "nvim-treesitter.configs".setup {
    ensure_installed = {
      "bash",
      "comment",
      "css",
      "go",
      "graphql",
      "query",
      "hcl",
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
    playground = {
      enable = true,
    },
    highlight = {
      enable = true
    },
    indent = { enable = false },
    autopairs = { enable = true },
    rainbow = { enable = true },
    autotag = { enable = true },
    context_commentstring = { enable = true },
  }
end
