return function()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_tool_installer = require("mason-tool-installer")

  -- Language servers
  -- Docs: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  local servers = {
    -- LSP's we don't override
    "ansiblels",
    "bashls",
    "helm_ls",
    "html",
    "jsonnet_ls",
    "tailwindcss",
    "terraformls",
    -- LSPs we override
    "gopls",
    "pyright",
    "rust_analyzer",
    "tsserver",
    "jsonls",
    "lua_ls",
    "cssls",
  }

  -- enable mason and configure icons
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  -- Ensure all servers are installed
  mason_lspconfig.setup({
    ensure_installed = servers,
  })

  mason_tool_installer.setup({
    ensure_installed = {
      "prettier", -- prettier formatter
      "stylua", -- lua formatter
      "isort", -- python formatter
      "black", -- python formatter
      "pylint",
      "eslint_d",
    },
  })
end
