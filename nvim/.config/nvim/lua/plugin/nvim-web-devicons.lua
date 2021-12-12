return function()
  local colors = require("utils.colors")
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
    };
    default = true;
  }
end
