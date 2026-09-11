-- TODO: Disable @comment.todo.comment
return function()
	-- tree-sitter CLI >= 0.26 dropped --no-bindings, which the frozen nvim-treesitter master still passes
	require("nvim-treesitter.install").ts_generate_args = { "generate", "--abi", vim.treesitter.language_version }
	require("nvim-treesitter.configs").setup({
		auto_install = true,
		ensure_installed = {
			"bash",
			"comment",
			"css",
			"go",
			"graphql",
			"query",
			"hcl",
			"helm",
			"html",
			"javascript",
			"jsonnet",
			"typescript",
			"tsx",
			"jsdoc",
			"json",
			"lua",
			"vim",
			"dockerfile",
			"python",
			"regex",
			"rust",
			"swift",
			"toml",
			"vue",
			"yaml",
			"markdown",
			"markdown_inline",
			"nginx",
		},
		playground = {
			enable = false,
		},
		highlight = {
			enable = true,
		},
		indent = { enable = true, disable = { "python" } },
		autopairs = { enable = true },
		rainbow = { enable = true },
		autotag = { enable = true },
		context_commentstring = { enable = true },
	})

	-- Fix folding on file open - ensure treesitter has parsed before setting up folds
	vim.api.nvim_create_autocmd({ "BufReadPost", "FileType" }, {
		pattern = "*",
		callback = function()
			-- Delay to ensure treesitter has fully parsed
			vim.defer_fn(function()
				-- Only use treesitter folding if a parser is available for this filetype
				local ok, parser = pcall(vim.treesitter.get_parser, 0)
				if ok and parser then
					vim.opt_local.foldmethod = "expr"
					vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
					-- Force fold recalculation
					vim.cmd("normal! zx")
				else
					-- Fallback to indent-based folding
					vim.opt_local.foldmethod = "indent"
				end
			end, 100)
		end,
	})
end
