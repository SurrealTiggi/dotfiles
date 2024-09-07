return function()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			["*"] = { "trim_whitespace", "trim_newlines" },
			bash = { "shfmt" },
			css = { "prettier" },
			golang = { "gofumpt", "goimports" },
			graphql = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "prettier" },
			liquid = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			python = { "isort", "black" },
			svelte = { "prettier" },
			terraform = { "terraform_fmt" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			yaml = { "yamlfmt" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
		},
	})

	vim.keymap.set({ "n", "v" }, "<leader>mp", function()
		conform.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		})
	end, { desc = "Format file or range (in visual mode)" })
end
