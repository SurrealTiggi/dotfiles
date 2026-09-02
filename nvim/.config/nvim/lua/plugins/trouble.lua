return function()
  require("trouble").setup {
    auto_close=true,
    height=25,
    use_diagnostic_signs = true, -- Use same signs as LSP
  }
end
