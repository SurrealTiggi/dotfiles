return function()
	-- Use the global SYMBOLS table for consistency
	local icons = SYMBOLS.lsp_symbols

	require("outline").setup({
		outline_window = {
			position = "right",
			width = 30,
			relative_width = true,
		},
		outline_items = {
			show_symbol_details = true,
			show_symbol_lineno = true,
		},
		-- Use nerd font icons from SYMBOLS global
		symbols = {
			icons = {
				File = { icon = icons.File, hl = "Identifier" },
				Module = { icon = icons.Module, hl = "Include" },
				Namespace = { icon = icons.Namespace, hl = "Include" },
				Package = { icon = icons.Package, hl = "Include" },
				Class = { icon = icons.Class, hl = "Type" },
				Method = { icon = icons.Method, hl = "Function" },
				Property = { icon = icons.Property, hl = "Identifier" },
				Field = { icon = icons.Field, hl = "Identifier" },
				Constructor = { icon = icons.Constructor, hl = "Special" },
				Enum = { icon = icons.Enum, hl = "Type" },
				Interface = { icon = icons.Interface, hl = "Type" },
				Function = { icon = icons.Function, hl = "Function" },
				Variable = { icon = icons.Variable, hl = "Constant" },
				Constant = { icon = icons.Constant, hl = "Constant" },
				String = { icon = icons.String, hl = "String" },
				Number = { icon = icons.Number, hl = "Number" },
				Boolean = { icon = icons.Boolean, hl = "Boolean" },
				Array = { icon = icons.Array, hl = "Constant" },
				Object = { icon = icons.Object, hl = "Type" },
				Key = { icon = icons.Key, hl = "Type" },
				Null = { icon = icons.Null, hl = "Type" },
				EnumMember = { icon = icons.EnumMember, hl = "Identifier" },
				Struct = { icon = icons.Struct, hl = "Structure" },
				Event = { icon = icons.Event, hl = "Type" },
				Operator = { icon = icons.Operator, hl = "Identifier" },
				TypeParameter = { icon = icons.TypeParameter, hl = "Identifier" },
			},
		},
	})
end
