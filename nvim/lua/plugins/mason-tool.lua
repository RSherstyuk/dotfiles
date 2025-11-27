return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},

		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"autopep8",
					"basedpyright",
					"bash-language-server",
					"buf",
					"checkstyle",
					"debugpy",
					"eslint_d",
					"isort",
					"java-debug-adapter",
					"java-test",
					"jdtls",
					"jsonlint",
					"kotlin-lsp",
					"lua-language-server",
					"markdownlint",
					"prettier",
					"protolint",
					"pylint",
					"ruff",
					"sqlfluff",
					"stylelint",
					"stylua",
					"typescript-language-server",
					"yamllint",
				},
				start_delay = 0,
			})
		end,
	},
}
