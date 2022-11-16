return function()
	require("gitsigns").setup({
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 500,
		},
		current_line_blame_formatter = "<author> (<author_time:%Y-%m-%d>) -- <summary> [<abbrev_sha>]",
		-- current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
	})
end
