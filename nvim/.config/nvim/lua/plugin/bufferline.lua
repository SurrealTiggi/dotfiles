return function()
	require("bufferline").setup({
		options = {
			numbers = "none",
			close_command = "bdelete! %d",

			indicator = {
				icon = SYMBOLS.misc.indicator,
			},
			buffer_close_icon = SYMBOLS.misc.close_light,
			modified_icon = SYMBOLS.git_symbols.git["staged"],
			close_icon = SYMBOLS.misc.close_heavy,
			left_trunc_marker = SYMBOLS.misc.left,
			right_trunc_marker = SYMBOLS.misc.right,
			max_name_length = 18,
			max_prefix_length = 15,
			tab_size = 18,
			diagnostics = "nvim_lsp",
			diagnostics_update_in_insert = false,
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				if context.buffer:current() then
					return ""
				else
					return "[" .. count .. "]"
				end
			end,

			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					highlight = "Directory",
				},
			},
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			persist_buffer_sort = true,

			separator_style = "slant",
			enforce_regular_tabs = false,
			always_show_bufferline = true,
			sort_by = "id",
		},
	})
end
