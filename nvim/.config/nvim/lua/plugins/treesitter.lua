-- TODO: Disable @comment.todo.comment
return function()
	require("nvim-treesitter").install({
		"bash",
		"comment",
		"css",
		"dockerfile",
		"go",
		"graphql",
		"hcl",
		"helm",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"jsonnet",
		"lua",
		"markdown",
		"markdown_inline",
		"nginx",
		"python",
		"query",
		"regex",
		"rust",
		"swift",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
	})

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("UserTreesitter", {}),
		callback = function(ev)
			if not pcall(vim.treesitter.start, ev.buf) then
				vim.wo[0][0].foldmethod = "indent"
				return
			end
			vim.wo[0][0].foldmethod = "expr"
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			if ev.match ~= "python" then
				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end,
	})
end
