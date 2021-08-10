


-- Config for utility plugins

-- TODO: Move to packer
-- color config from https://github.com/lukas-reineke/indent-blankline.nvim/issues/160
-- vim.cmd [[highlight IndentOne guifg=#BF616A guibg=NONE gui=nocombine]]
-- vim.cmd [[highlight IndentTwo guifg=#D08770 guibg=NONE gui=nocombine]]
-- vim.cmd [[highlight IndentThree guifg=#EBCB8B guibg=NONE gui=nocombine]]
-- vim.cmd [[highlight IndentFour guifg=#A3BE8C guibg=NONE gui=nocombine]]
-- vim.cmd [[highlight IndentFive guifg=#5E81AC guibg=NONE gui=nocombine]]
-- vim.cmd [[highlight IndentSix guifg=#88C0D0 guibg=NONE gui=nocombine]]
-- vim.cmd [[highlight IndentSeven guifg=#B48EAD guibg=NONE gui=nocombine]]

-- require("indent_blankline").setup {
    -- char = "▏",
    -- filetype_exclude = {"help", "terminal", "dashboard", "NvimTree", "markdown", "json", "txt", "git"},
    -- buftype_exclude = {"terminal"},
    -- char_highlight_list = {
      -- "IndentOne", "IndentTwo", "IndentThree", "IndentFour", "IndentFive",
      -- "IndentSix", "IndentSeven"
    -- },
    -- show_first_indent_level = true,
    -- show_trailing_blankline_indent = false,
    -- show_current_context = true,
    -- context_patterns = {
      -- "class", "function", "method", "block", "list_literal", "selector",
      -- "^if", "^table", "if_statement", "while", "for"
    -- }
-- }
