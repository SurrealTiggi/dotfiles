-- Folding doesn't work when opening anything via Telescope for some reason
-- so overriding a bunch of builtins to fix it
-- from https://github.com/nvim-telescope/telescope.nvim/issues/559

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')

telescope.setup({
  defaults = {
    mapping = {
      ["<cr>"] = actions.select_default + actions.center,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorted = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
})

local find_files_opts = {
  attach_mappings = function(_)
    actions.center:replace(function(_)
      vim.wo.foldmethod = vim.wo.foldmethod or "expr"
      vim.wo.foldexpr = vim.wo.foldexpr or "nvim_treesitter#foldexpr()"
      vim.cmd(":normal! zx")
      vim.cmd(":normal! zz")
      pcall(vim.cmd, ":loadview") -- silent load view
    end)
    return true
  end,
}

builtin.my_find_files = function(opts)
  opts = opts or {}
  return builtin.find_files(vim.tbl_extend("error", find_files_opts, opts))
end

builtin.my_live_grep = function(opts)
  opts = opts or {}
  return builtin.live_grep(vim.tbl_extend("error", find_files_opts, opts))
end

builtin.my_oldfiles = function(opts)
  opts = opts or {}
  return builtin.oldfiles(vim.tbl_extend("error", find_files_opts, opts))
end
