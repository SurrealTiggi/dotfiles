-- [[ LSP HANDLERS ]] --
------------------------
-- Ensure completion engine is installed
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

-- Highlight all instances of symbol under cursor
local function lsp_highlight_document(client)
  -- Only enable if the active LSP supports it
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

-- Setup basic keybinds
-- TODO: Tweak diagnostics to use something else (maybe lsp-saga, or folke/trouble?)
-- TODO: Can we configure these elsewhere?
local function lsp_keymaps(bufnr)
  -- Quick function to keep things more readable
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- General keybind options
  local opts = { noremap = true, silent = true }

  -- Code navitation keybinds
  buf_set_keymap("n", "gd",         "<cmd>lua vim.lsp.buf.definition()<CR>", opts)                    -- Go to definition
  buf_set_keymap("n", "K",          "<cmd>lua vim.lsp.buf.hover()<CR>", opts)                         -- Hoverdoc
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)                        -- Rename under cursor
  buf_set_keymap("n", "gr",         "<cmd>lua vim.lsp.buf.references()<CR>", opts)                    -- Get references
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)                   -- Code action
  buf_set_keymap("n", "<C-k>",      "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)                  -- Go to previous diagnostic
  buf_set_keymap("n", "<C-j>",      "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)                  -- Go to next diagnostic
  buf_set_keymap("n", "gl",         "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)  -- Show line diagnostics
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- Bring in default LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

local M = {}

-- Initial setup
M.setup = function()
  local signs = SYMBOLS.diagnostic_signs

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  -- Diagnostics config
  local diagnostics_config = {
    virtual_text = false,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(diagnostics_config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

-- Setup on-attach
M.on_attach = function(client, bufnr)
  -- Remove formatting for TS/JS since we'll use prettier
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  -- Remove formatting for Py since we'll use black
  if client.name == "pyright" then
    client.resolved_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

-- Merge LSP capabilities with completion engine
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
