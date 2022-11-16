return function()
	local colors = COLORS

	if colors == nil then
		print("ERROR: No colors provided, so icon overrides won't be set")
		require("nvim-web-devicons").setup()
	else
		-- @SurrealTiggi: nvim-web-devicons only supports filtering by extensions or full file name
		-- TODO: by filetype https://github.com/kyazdani42/nvim-web-devicons/pull/125
		-- regex support https://github.com/kyazdani42/nvim-web-devicons/issues/36
		require("nvim-web-devicons").setup({
			override = {
				["package.json"] = {
					icon = SYMBOLS.files.package_json,
					color = colors.green,
					name = "PackageJson",
				},
				["Makefile"] = {
					icon = SYMBOLS.files.makefile,
					color = colors.peach,
					name = "Makefile",
				},
				["Justfile"] = {
					icon = SYMBOLS.files.makefile,
					color = colors.orange,
					name = "Justfile",
				},
				["CODEOWNERS"] = {
					icon = SYMBOLS.misc.github,
					color = colors.darker_black,
					name = "CODEOWNERS",
				},
				[".env"] = {
					icon = SYMBOLS.misc.tree,
					color = colors.vibrant_green,
					name = "env",
				},
				md = {
					icon = SYMBOLS.files.markdown,
					colors = colors.blue,
					name = "markdown",
				},
				yaml = {
					icon = SYMBOLS.files.yaml,
					color = colors.yellow,
					name = "yaml",
				},
				yml = {
					icon = SYMBOLS.files.yaml,
					color = colors.yellow,
					name = "yml",
				},
				tf = {
					icon = SYMBOLS.files.terraform,
					color = colors.dark_purple,
					name = "tf",
				},
				hcl = {
					icon = SYMBOLS.files.terraform,
					color = colors.dark_purple,
					name = "hcl",
				},
				sh = {
					icon = SYMBOLS.files.shell,
					color = colors.green,
					name = "sh",
				},
				[".secrets.baseline"] = {
					icon = SYMBOLS.misc.lock,
					color = colors.white,
					name = "GitIgnore",
				},
				[".gitignore"] = {
					icon = SYMBOLS.git_symbols.git["unmerged"],
					color = colors.vibrant_green,
					name = "GitIgnore",
				},
				py = {
					icon = SYMBOLS.files.python,
					color = colors.orange,
					name = "py",
				},
				["go.mod"] = {
					icon = SYMBOLS.files.golang,
					color = colors.teal,
					name = "GoMod",
				},
				html = {
					icon = SYMBOLS.files.html,
					color = colors.orange,
					name = "html",
				},
				css = {
					icon = SYMBOLS.files.css,
					color = colors.blue,
					name = "css",
				},
				cjs = {
					icon = SYMBOLS.files.javascript,
					color = colors.sun,
					name = "js",
				},
				js = {
					icon = SYMBOLS.files.javascript,
					color = colors.sun,
					name = "js",
				},
				ts = {
					icon = SYMBOLS.files.typescript,
					color = colors.teal,
					name = "ts",
				},
				Dockerfile = {
					icon = SYMBOLS.files.docker,
					color = colors.cyan,
					name = "Dockerfile",
				},
				vue = {
					icon = SYMBOLS.files.vue,
					color = colors.vibrant_green,
					name = "vue",
				},
				toml = {
					icon = SYMBOLS.files.toml,
					color = colors.blue,
					name = "toml",
				},
				lock = {
					icon = SYMBOLS.misc.lock,
					color = colors.peach,
					name = "lock",
				},
				prisma = {
					icon = SYMBOLS.files.prisma,
					color = colors.cyan,
					name = "prisma",
				},
			},
			default = false,
		})
	end
end
