local nvim_lsp = require("lspconfig")
local lsp_config = {}

-- Setup :LspInstall
-- FIXME: Enabling this does something weird with filetype, check LunarVim
-- require("lspinstall").setup()



-- Setup completion symbols
vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ", -- \uf52b
  "   (Method)", -- \uf6a6
  "   (Function)", -- \uf794
  " 練 (Constructor)",
  " ﰠ  (Field)", -- \ufc20
  "   (Variable)", -- \uf292
  " ﴰ  (Class)", -- \ufd30
  "   (Interface)", -- \uf417
  "   (Module)", -- \uf668
  " ﰊ  (Property)", -- \ufc0a
  "   (Unit)", -- \uf475
  "   (Value)", -- \uf89f
  "   (Enum)", -- \uf779
  "   (Keyword)", -- \uf805
  "   (Snippet)", -- \uf674
  "   (Color)", -- \ue22b
  "   (File)", -- \uf723
  "   (Reference)", -- \ufa46
  "   (Folder)", -- \uf114
  "   (EnumMember)",
  "   (Constant)", -- \uf8fe
  "   (Struct)", -- \uf1b3
  "   (Event)", -- \uf0e7
  " ﬦ  (Operator)", -- \ufb26
  "   (TypeParameter)", -- \uf673
}

-- Global on_attach override
function lsp_config.common_on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'td', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'tK', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'trn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'ta', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'tr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

-- Global capabilities override
function lsp_config.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- capabilities.textDocument.completion.completionItem.resolveSupport = {
    -- properties = {
      -- "documentation",
      -- "detail",
      -- "additionalTextEdits",
    -- },
  -- }
  return capabilities
end


-- Re-usable generic setup override to be called via ftplugin
function lsp_config.setup(lang)
  local lang_server = my_nvim.lang[lang].lsp
  local provider = lang_server.provider

  require("lspconfig")[provider].setup(lang_server.setup)
end

return lsp_config
