-- Folding doesn't work when opening anything via Telescope for some reason
-- so overriding a bunch of builtins to fix it
-- https://github.com/nvim-telescope/telescope.nvim/issues/559#issuecomment-934727312
-- Update: Folding seems to be working again so no longer using workaround above

-- syntax adapted from https://github.com/martinsione/dotfiles

return function()
    local installed, telescope = pcall(require, "telescope")
    if not installed then
        return
    end

    -- [[ Imports for convenience ]] --
    local actions = require("telescope.actions")
    local pickers = require("telescope.pickers")
    local previewers = require("telescope.previewers")
    local builtin = require("telescope.builtin")

    -- [[ Main telescope config ]] --
    telescope.setup({
      defaults = {
        prompt_prefix = "  ",
        selection_caret = " ",
        layout_config = {
          height = 0.9,
          width = 0.75,
          preview_cutoff = 120,
          prompt_position = "top"
        },
        sorting_strategy = "ascending",
        path_display = { shorten = 5 },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,

        file_sorter = require("telescope.sorters").get_fzy_sorter,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        vimgrep_arguments = {
          'ag',
          '--hidden',
          '--nocolor',
          '--noheading',
          '--filename',
          '--numbers',
          '--column',
          '--smart-case',
        },
        file_ignore_patterns = {
          '^.git/',
          'go.sum','go.mod',
          'package-lock.json',
          'yarn.lock'
        },
        mapping = {
          ["<cr>"] = actions.select_default + actions.center,
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type=file", "--hidden" }
        }
      },
      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },
      }
    })
    require("telescope").load_extension("fzy_native")
end
