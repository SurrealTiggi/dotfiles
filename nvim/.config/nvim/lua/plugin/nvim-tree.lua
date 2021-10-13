return function()

  local g = vim.g
  -- local colors = require("colors")

  g.nvim_tree_ignore = {
    "\\~$", "bower_components", "node_modules", ".cache", "__pycache__", ".pytest_cache", ".mypy_cache", ".vim",
    ".git", ".aws-sam", "dist", ".terraform", "resources$[[dir]]", "go.sum",
    "build$[[dir]]", "bin$[[dir]]", "yarn.lock", ".nuxt$[[dir]]", ".next$[[dir]]"
  }
  g.nvim_tree_gitignore = 1 -- Hide any files specified in .gitignore
  g.nvim_tree_quit_on_open = 1
  g.nvim_tree_width = 50
  g.nvim_tree_width_allow_resize = 1
  g.nvim_tree_auto_resize=1
  g.nvim_tree_lsp_diagnostics = 1

  g.nvim_tree_show_icons = {
      git = 1,
      folders = 1,
      files = 1
  }

  g.nvim_tree_special_files = "" -- Don't highlight any files

  -- Purely for aesthetics
  g.nvim_tree_icons = {
     default = "",
     symlink = "",
     git = {
       unstaged = "✗",
       staged = "●",
       unmerged = "",
       renamed = "➜",
       untracked = "",
       deleted = "",
       ignored = "◌"
     }
   }
  require"nvim-tree".setup{}
 end
