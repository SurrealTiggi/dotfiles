-- Folding doesn't work when opening anything via Telescope for some reason
-- so overriding a bunch of builtins to fix it
-- from https://github.com/nvim-telescope/telescope.nvim/issues/559

-- syntax adapted from https://github.com/martinsione/dotfiles

return function()
    local present, telescope = pcall(require, "telescope")
    if not present then
        return
    end
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")

    local telescope_actions = require("telescope.actions.set")

    local fixfolds = {
	    hidden = true,
	    attach_mappings = function(_)
        telescope_actions.select:enhance({
          post = function()
            vim.cmd(":normal! zx")
          end,
        })
		    return true
	    end,
    }

    -- require('telescope').load_extension('coc')
    require('telescope').load_extension('fzf')

    telescope.setup({
      defaults = {
        find_command = {
          "ag",
          "--hidden",
          "--no-heading",
          "--with-filename",
          "--no-line-number",
          "--no-column",
          "--smart-case",
        },
        prompt_prefix = "  ",
        selection_caret = " ",
        sorting_strategy = "descending",
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        file_ignore_patterns = {},
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { shorten = 5 },
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        mapping = {
          ["<cr>"] = actions.select_default + actions.center,
        },
      },
      pickers = {
		    buffers = fixfolds,
		    file_browser = fixfolds,
		    find_files = fixfolds,
		    git_files = fixfolds,
		    grep_string = fixfolds,
		    live_grep = fixfolds,
		    oldfiles = fixfolds,
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = false,
          override_file_sorter = true,
          case_mode = "smart_case"
        }
      }
    })

--    local find_files_opts = {
--      attach_mappings = function(_)
--        actions.center:replace(function(_)
--          vim.wo.foldmethod = vim.wo.foldmethod or "expr"
--          vim.wo.foldexpr = vim.wo.foldexpr or "nvim_treesitter#foldexpr()"
--          vim.cmd(":normal! zx")
--          vim.cmd(":normal! zz")
--          pcall(vim.cmd, ":loadview") -- silent load view
--        end)
--        return true
--      end,
--    }

--    builtin.my_find_files = function(opts)
--      opts = opts or {}
--      return builtin.find_files(vim.tbl_extend("error", find_files_opts, opts))
--    end

--    builtin.my_live_grep = function(opts)
--      opts = opts or {}
--      return builtin.live_grep(vim.tbl_extend("error", find_files_opts, opts))
--    end

--    builtin.my_oldfiles = function(opts)
--      opts = opts or {}
--      return builtin.oldfiles(vim.tbl_extend("error", find_files_opts, opts))
--    end
end
