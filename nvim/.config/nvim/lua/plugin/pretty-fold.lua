return function()
	-- TODO: move to symbols.lua
	require("pretty-fold").setup({
		fill_char = "━",
		sections = {
			left = {
				SYMBOLS.misc.hint_prefix .. " ",
				"content",
				"┣",
			},
			right = {
				"┫ ",
				"number_of_folded_lines",
				": ",
				"percentage",
				" ┣━━",
			},
		},
	})
end
