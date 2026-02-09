local cmp = require("cmp")
cmp.setup({
	completion = { autocomplete = false },
	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
	},

	sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "cmp-dbee" } }),
})

cmp.setup.filetype('sql', {
  sources = cmp.config.sources({
    { name = 'cmp-dbee' },
    { name = 'buffer' },
  })
})

