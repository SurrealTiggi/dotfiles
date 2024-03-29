return function()
  require("toggleterm").setup{
    size = 5,
    -- open_mapping = [[<c-z>]] -- disabled to try and keep all maps in keybinds.vim
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = 'single',
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    }
  }

  local Terminal  = require('toggleterm.terminal').Terminal
  local gitui = Terminal:new({ cmd = "gitui", hidden = true })

  function _gitui_toggle()
    gitui:toggle()
  end
end
