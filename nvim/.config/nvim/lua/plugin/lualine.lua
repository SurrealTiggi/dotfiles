return function()

  local function tree()
    return "פּ NvimTree"
  end

  local function term()
    return "HI"
  end

  local prettier_tree = {
    sections = {
      lualine_a = { tree },
    },
    filetypes = {'NvimTree'}
  }

  local prettier_term = {
    sections = {
      lualine_a = { term },
    },
    filetypes = {'toggleterm'}
  }

  require'lualine'.setup {
    options = {
      icons_enabled = true,
      theme = 'wombat',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {},
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
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
    extensions = {prettier_tree, prettier_toggle}
  }
end
