return function()
  local g = vim.g
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback

  g.nvim_tree_gitignore = 1 -- Hide any files specified in .gitignore
  g.nvim_tree_indent_markers = 1
  g.nvim_tree_quit_on_open = 1
  g.nvim_tree_width_allow_resize = 1

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
      ignored = ""
    }
  }

  require"nvim-tree".setup{
    hijack_cursor = true,
    diagnostics = {
      enable = true
    },
    view = {
      hide_root_folder = true,
      width = 50,
      auto_resize = true,
      mappings = {
        list = {
          { key = "<C-s>",          cb = tree_cb("vsplit") },
          { key = "<C-i>",          cb = tree_cb("split") },
          { key = "<C-t>",          cb = tree_cb("tabnew") },
        }
      }
    },
    filters = {
      dotfiles = false,
      custom = {
        "\\~$", "bower_components", "node_modules", ".cache", "__pycache__", ".pytest_cache", ".mypy_cache", ".vim",
        ".DS_Store",
        ".terragrunt-cache",
        ".git", ".aws-sam", "dist", ".terraform", "resources$[[dir]]", "go.sum",
        "build$[[dir]]", "bin$[[dir]]", "yarn.lock", ".nuxt$[[dir]]", ".next$[[dir]]"
      }
    }
  }
 end
