return function()

  local function tree()
    return SYMBOLS.misc.nav_tree .. " NvimTree"
  end

  local function symbol_tree()
    return SYMBOLS.misc.symbol_tree .. " Symbols"
  end

  local prettier_tree = {
    sections = {
      lualine_a = { tree },
    },
    filetypes = {'NvimTree'}
  }

  local prettier_symbols = {
    sections = {
      lualine_z = { symbol_tree },
    },
    filetypes = {'Outline'}
  }

  local alpha_hide = {
    sections = {},
    filetypes = {'alpha'}
  }

  require'lualine'.setup {
    options = {
      icons_enabled = true,
      theme = 'tokyonight',
      component_separators = { left = SYMBOLS.misc.left_separator_light, right = SYMBOLS.misc.right_separator_light },
      section_separators = { left = SYMBOLS.misc.left_separator_heavy, right = SYMBOLS.misc.right_separator_heavy },
      disabled_filetypes = {},
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {},
      lualine_z = {'progress', 'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = { prettier_tree, prettier_symbols, alpha_hide }
  }
end
