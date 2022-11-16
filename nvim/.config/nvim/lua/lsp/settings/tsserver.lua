return {
	on_attach = function(client, bufnr)
		-- @SurrealTiggi Since we're overriding lsp.handlers.on_attach, we have to duplicate some of the settings
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false

		-- Add lsp_signature
		require("lsp_signature").on_attach(require("lsp.lsp-config").lsp_signature_opts)

		local ts_utils = require("nvim-lsp-ts-utils")

		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = true,
			import_all_timeout = 5000, -- ms

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},

			-- inlay hints
			-- @SurrealTiggi disabled since we use lsp_signature
			auto_inlay_hints = false,
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		-- TODO: Set up autocommands for some of these
		-- local opts = { silent = true }
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganizeSync<CR>", opts)
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
	end,
}
