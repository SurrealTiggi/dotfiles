return function()
	-- Note: LSP server setup is now handled in mason.lua via setup_handlers
	-- This file only configures keybindings and diagnostics

	local keymap = vim.keymap -- for conciseness

	-- Configure diagnostic display to show source
	vim.diagnostic.config({
		virtual_text = {
			source = "always", -- Show source (LSP name) in virtual text
			prefix = "●",
		},
		float = {
			source = "always", -- Show source in hover window
			border = "rounded",
			header = "",
			prefix = "",
			format = function(diagnostic)
				-- Format: [source] message
				return string.format("[%s] %s", diagnostic.source or "unknown", diagnostic.message)
			end,
		},
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf, silent = true }

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			-- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			-- Ctrl+j/k for jumping between diagnostics with automatic popup
			opts.desc = "Next diagnostic with popup"
			keymap.set("n", "<C-j>", function()
				vim.diagnostic.goto_next()
				vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
			end, opts)

			opts.desc = "Previous diagnostic with popup"
			keymap.set("n", "<C-k>", function()
				vim.diagnostic.goto_prev()
				vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
			end, opts)

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end,
	})

	-- Change the Diagnostic symbols in the sign column (gutter)
	local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end
