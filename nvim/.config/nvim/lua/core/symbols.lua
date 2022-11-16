local M = {}
-- Extra random icons
--   \uf5cf
-- 
-- ﯟ
--   \ue624
--   \ue20f
--   \uf0e8
-- 
-- 
-- 
-- 
-- 
-- 
--  \uf52a
--  \ue27e

-- Git symbols
M.git_symbols = {
	default = "",
	symlink = "",
	git = {
		unstaged = "✗",
		staged = "●",
		unmerged = "",
		renamed = "➜",
		untracked = "",
		deleted = "",
		ignored = "",
	},
}

-- LSP Type Symbols
M.lsp_symbols = {
	Text = "", -- \uf77e
	Method = "", -- \uf6a6
	Function = "", -- \uf794
	Constructor = "練",
	Field = "ﰠ", -- \ufc20
	Variable = "", -- \uf292
	Class = "ﴰ", -- \ufd30
	Interface = "", -- \uf417
	Module = "", -- \uf668
	Property = "ﰊ", -- \ufc0a
	Unit = "", -- \uf475
	Value = "", -- \uf89f
	Enum = "", -- \uf779
	Keyword = "", -- \uf805
	Snippet = "", -- \uf674
	Color = "", -- \ue22b
	File = "", -- \uf723
	Reference = "", -- \ufa46
	Folder = "", -- \uf114
	EnumMember = "",
	Constant = "", -- \uf8fe
	Struct = "", -- \uf1b3
	Event = "", -- \uf0e7
	Operator = "ﬦ", -- \ufb26
	TypeParameter = "", -- \uf673
	-- The rest were added for the outline tree
	Boolean = "", -- \uf53c
	Package = "", -- \uf8d6
	Namespace = "", -- \uf5c6
	String = "", -- \uf52b
	Number = "", -- \uf89f
	Array = "", -- \uf669
	Object = "", -- \uf6a1
	Key = "", -- \uf805
	Null = "", -- \uf8dc
}

-- LSP Diagnostic Signs
M.diagnostic_signs = {
	Error = " ﯇",
	Warn = " ",
	Hint = " ",
	Info = " ",
	Other = " ",
}

-- Borders
M.borders = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

-- Misc (until I refactor this)
-- see https://github.com/CosmicNvim/CosmicNvim/blob/main/lua/cosmic/theme/icons.lua
M.misc = {
	nav_tree = "פּ",
	symbol_tree = "", -- \uf487
	left = "",
	right = "",
	left_separator_light = "",
	right_separator_light = "",
	left_separator_heavy = "",
	right_separator_heavy = "",
	indicator = "▎",
	file = "",
	finder = "",
	recent = "",
	settings = "",
	close = "",
	close_heavy = "",
	close_light = "",
	indent_line = "", -- ┆ ┊ 
	plugin = " ",
	debug = " ",
	ghost = " ",
	github = "",
	tree = "",
	lock = "",
	search = "",
	selector = "",
	hint_prefix = "❱❱❱",
}

M.files = {
	markdown = "",
	package_json = "",
	makefile = "",
	yaml = "ﬥ",
	terraform = "",
	shell = "",
	python = "",
	golang = "",
	html = "",
	css = "",
	javascript = "",
	typescript = "",
	docker = "",
	vue = "﵂",
	toml = "",
	prisma = "喝",
}

return M
