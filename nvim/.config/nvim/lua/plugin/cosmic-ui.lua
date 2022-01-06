return function()
  -- TODO: Tweak this
  require("cosmic-ui").setup({
    -- default border to use
    -- 'single', 'double', 'rounded', 'solid', 'shadow'
    border = 'rounded',

    -- rename popup settings
    rename = {
      prompt = '> ',
      -- same as nui popup options
      popup_opts = {
        position = {
          row = 1,
          col = 0,
        },
        size = {
          width = 25,
          height = 2,
        },
        relative = 'cursor',
        border = {
          highlight = 'FloatBorder',
          style = _G.CosmicUI_user_opts.border,
          text = {
            top = ' Rename ',
            top_align = 'left',
          },
        },
        win_options = {
          winhighlight = 'Normal:Normal',
        },
      },
    },

    code_actions = {
      min_width = {},
      -- same as nui popup options
      popup_opts = {
        position = {
          row = 1,
          col = 0,
        },
        relative = 'cursor',
        border = {
          highlight = 'FloatBorder',
          text = {
            top = 'Code Actions',
            top_align = 'center',
          },
          padding = { 0, 1 },
        },
      },
    }
  })
end
