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
					"buf",
					"checkstyle",
					"lua-language-server",
					"markdownlint",
					"prettier",
					"protolint",
					"ruff",
					"sqlfluff",
					"stylelint",
					"stylua",
				},
				start_delay = 0,
			})
		end,
	},
}
