return {
	settings = {
		["rust-analyzer"] = {
			assist = {
				importGranularity = "module",
				importPrefix = "self",
			},
			inlayHints = {
				enable = true,
				chainingHints = true,
				maxLength = 25,
				parameterHints = true,
				typeHints = true,
				hideNamedConstructorHints = false,
				typeHintsSeparator = "‣",
				typeHintsWithVariable = true,
				chainingHintsSeparator = "‣",
			},
			cargo = {
				loadOutDirsFromCheck = true,
			},
			procMacro = {
				enable = true,
			},
		},
	},
}
