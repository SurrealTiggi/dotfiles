local M = {}
-- Extra random icons
--   פּ ﯟ      

-- LSP Type Symbols
M.lsp_symbols = {
  Text = "",           -- \uf77e
  Method = "",         -- \uf6a6
  Function = "",       -- \uf794
  Constructor = "練",
  Field = "ﰠ",          -- \ufc20
  Variable = "",       -- \uf292
  Class = "ﴰ",          -- \ufd30
  Interface = "",      -- \uf417
  Module = "",         -- \uf668
  Property = "ﰊ",       -- \ufc0a
  Unit = "",           -- \uf475
  Value = "",          -- \uf89f
  Enum = "",           -- \uf779
  Keyword = "",        -- \uf805
  Snippet = "",        -- \uf674
  Color = "",          -- \ue22b
  File = "",           -- \uf723
  Reference = "",      -- \ufa46
  Folder = "",         -- \uf114
  EnumMember = "",
  Constant = "",       -- \uf8fe
  Struct = "",         -- \uf1b3
  Event = "",          -- \uf0e7
  Operator = "ﬦ",       -- \ufb26
  TypeParameter = "",  -- \uf673
}

-- LSP Diagnostic Signs
M.diagnostic_signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

return M
