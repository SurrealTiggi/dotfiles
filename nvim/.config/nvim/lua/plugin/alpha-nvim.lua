return function ()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  local function pick_color()
    local colors = {"String", "Identifier", "Keyword", "Number"}
    return colors[math.random(#colors)]
  end

  local function button(sc, txt, keybind, keybind_opts)
    local b = dashboard.button(sc, txt, keybind, keybind_opts)
    b.opts.hl = "Function"
    b.opts.hl_shortcut = "Type"
    return b
  end

  local function footer()
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date("%d-%m-%Y  %H:%M:%S")
    return total_plugins .. " plugins  " .. datetime
  end

  -- Set header
  dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  }
  dashboard.section.header.opts.hl = pick_color()

  -- Set menu
  dashboard.section.buttons.val = {
    button( "e", "  > New file" ,    ":ene <BAR> startinsert <CR>"),
    button( "f", "  > Find file",    ":Telescope find_files<CR>"),
    button( "r", "  > Recent Files", ":Telescope oldfiles cwd_only=true<CR>"),
    button( "s", "  > Settings" ,    ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    button( "q", "  > Quit NVIM",    ":qa<CR>"),
  }

  dashboard.section.footer.val = footer()
  dashboard.section.footer.opts.hl = "Constant"

  -- Send config to alpha
  alpha.setup(dashboard.opts)

  -- Disable folding on alpha buffer
  vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
  ]])

  -- hide tabline on startup screen
  vim.cmd [[
    augroup alpha_clear
      autocmd!
      autocmd FileType alpha set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    augroup END
  ]]

end
