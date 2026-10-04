return function()
	local function tree()
		return SYMBOLS.misc.nav_tree .. " NvimTree"
	end

	local function symbol_tree()
		return SYMBOLS.misc.symbol_tree .. " Symbols"
	end

	-- The stock component only shows a symbol for servers that report progress;
	-- seeding every attached client at zero work makes idle read as attached.
	local LspStatus = require("lualine.components.lsp_status"):extend()
	function LspStatus:update_status()
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
			self.lsp_work_by_client_id[client.id] = self.lsp_work_by_client_id[client.id] or 0
		end
		return LspStatus.super.update_status(self)
	end

	local prettier_tree = {
		sections = {
			lualine_a = { tree },
		},
		filetypes = { "NvimTree" },
	}

	local prettier_symbols = {
		sections = {
			lualine_z = { symbol_tree },
		},
		filetypes = { "Outline" },
	}

	local alpha_hide = {
		sections = {},
		filetypes = { "alpha" },
	}

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "catppuccin-nvim",
			component_separators = {
				left = SYMBOLS.misc.left_separator_light,
				right = SYMBOLS.misc.right_separator_light,
			},
			section_separators = {
				left = SYMBOLS.misc.left_separator_heavy,
				right = SYMBOLS.misc.right_separator_heavy,
			},
			disabled_filetypes = {},
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { { "filename", path = 1 } },
			lualine_x = {
				{
					LspStatus,
					icon = SYMBOLS.misc.lsp_status,
					color = { fg = require("catppuccin.palettes").get_palette().green },
				},
				"encoding",
				"fileformat",
				"filetype",
			},
			lualine_y = {},
			lualine_z = { "progress", "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = { prettier_tree, prettier_symbols, alpha_hide },
	})
end
