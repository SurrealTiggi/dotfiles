-- Global vars
CONFIG_PATH = os.getenv "HOME" .. "/.local/share/lunarvim/lvim"
DATA_PATH = vim.fn.stdpath "data" -- $HOME/.local/share/nvim
CACHE_PATH = vim.fn.stdpath "cache" -- $HOME/.cache/nvim
TERMINAL = vim.fn.expand "$TERMINAL"
USER = vim.fn.expand "$USER"

-- Setup plugins
require "pluginList"



-- TODO: Should move this where it makes sense
vim.g.python_host_prog = '$HOME/.asdf/shims/python'
vim.g.python3_host_prog = '$HOME/.asdf/shims/python3'

-- TODO: Config object + on_attach stuff should be a separate import
local common_on_attach = require("lsp").common_on_attach
local common_capabilities = require("lsp").common_capabilities


my_nvim = {}

my_nvim.lang = {
  go = {
    formatter = {
      exe = "gofmt",
      args = {},
      stdin = true,
    },
    linters = {
      "golangcilint",
      "revive",
    },
    lsp = {
      provider = "gopls",
      setup = {
        cmd = {
          -- os.getenv "HOME" .. "/go/bin/gopls",
          DATA_PATH .. "/lspinstall/go/gopls",
        },
        on_attach = common_on_attach,
        -- FIXME: common_capabilities crashes
        -- capabilities = common_capabilities,
      },
    },
  },
  lua = {
    formatters = {
      {
        -- @usage can be stylua or lua_format
        exe = "",
        args = {},
      },
    },
    linters = {},
    lsp = {
      provider = "sumneko_lua",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/lua/sumneko-lua-language-server",
          "-E",
          DATA_PATH .. "/lspinstall/lua/main.lua",
        },
        -- capabilities = common_capabilities,
        on_attach = common_on_attach,
        -- on_init = common_on_init,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Setup your lua path
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim", "lvim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                [vim.fn.expand "~/.local/share/lunarvim/lvim/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 1000,
            },
          },
        },
      },
    },
  },
}
