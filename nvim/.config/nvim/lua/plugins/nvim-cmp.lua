return function()
  local cmp = require("cmp")
  -- TODO: use our own symbols
	-- local cmp_symbols = SYMBOLS.lsp_symbols
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")

  -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
  require("luasnip.loaders.from_vscode").lazy_load()

	cmp.setup({
    completion = {
      completeopt = "menu,menuone,preview,noselect",
    },
		view = {
			entries = "native",
		},
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
		mapping = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(), -- close completion window
			["<CR>"] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		},
    formatting = {
      format = lspkind.cmp_format({
        maxwidth = 50,
        ellipsis_char = "...",
      }),
    },
		-- Force the order in which completion items are shown
    -- TODO: disable the "Text" source https://github.com/hrsh7th/nvim-cmp/issues/684
    -- TODO: Add an icon for codeium https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-custom-icons-for-any-source
		sources = {
      { name = "codeium" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "buffer", keyword_length = 5 },
		},
		window = {
			documentation = {
				border = SYMBOLS.borders,
			},
		},
	})
end
