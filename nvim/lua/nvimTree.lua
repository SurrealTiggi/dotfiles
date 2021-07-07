local g = vim.g
local colors = require("colors")

g.nvim_tree_ignore = {
  "\\~$", "bower_components", "node_modules", ".cache", "__pycache__", ".pytest_cache", ".mypy_cache", ".vim",
  ".git", ".aws-sam", "dist", ".terraform", "resources$[[dir]]", "go.sum",
  "build$[[dir]]", "bin$[[dir]]", "yarn.lock", ".nuxt$[[dir]]", ".next$[[dir]]"
}
g.nvim_tree_gitignore = 1 -- Hide any files specified in .gitignore
g.nvim_tree_quit_on_open = 1
g.nvim_tree_width = 50
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
     deleted = "",
     ignored = "◌"
   }
 }

-- Icon overrides
require "nvim-web-devicons".setup {
  override = {
    ["package.json"] = {
      icon = "",
      color = colors.green,
      name = "PackageJson"
    },
    ["Makefile"] = {
      icon = "",
      color = colors.peach,
      name = "Makefile"
    },
    yaml = {
      icon = "ﬥ",
      color = colors.yellow,
      name = "yaml"
    },
    yml = {
      icon = "ﬥ",
      color = colors.yellow,
      name = "yml"
    },
    tf = {
      icon = "",
      color = colors.dark_purple,
      name = "tf"
    },
    hcl = {
      icon = "",
      color = colors.dark_purple,
      name = "hcl"
    },
    sh = {
      icon = "",
      color = colors.green,
      name = "sh"
    },
    [".gitignore"] = {
      icon = "",
      color = colors.peach,
      name = "GitIgnore"
    };
    py = {
      icon = "",
      color = colors.orange,
      name = "py"
    },
    ["go.mod"] = {
      icon = "",
      color = colors.teal,
      name = "GoMod"
    },
    html = {
      icon = "",
      color = colors.orange,
      name = "html"
    },
    css = {
      icon = "",
      color = colors.blue,
      name = "css"
    },
    js = {
      icon = "",
      color = colors.sun,
      name = "js"
    },
    ts = {
      icon = "ﯤ",
      color = colors.teal,
      name = "ts"
    },
    Dockerfile = {
      icon = "",
      color = colors.cyan,
      name = "Dockerfile"
    },
    vue = {
      icon = "﵂",
      color = colors.vibrant_green,
      name = "vue"
    },
    toml = {
      icon = "",
      color = colors.blue,
      name = "toml"
    },
    lock = {
      icon = "",
      color = colors.peach,
      name = "lock"
    }
  }
}
