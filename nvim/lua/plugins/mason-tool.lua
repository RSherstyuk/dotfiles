return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},

		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"buf",
					"checkstyle",
					"java-debug-adapter",
					"java-test",
					"jdtls",
					"kotlin-lsp",
					"lua-language-server",
					"protolint",
				},
				start_delay = 0,
			})
		end,
	},
}
