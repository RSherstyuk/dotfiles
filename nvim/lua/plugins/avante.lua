return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	build = "make",
	version = false,
	opts = {
		provider = "gemini",
		auto_suggestions_provider = "gemini",
		providers = {
			gemini = {
				endpoint = "https://googleapis.com",
				model = "gemini-2.5-flash",
				timeout = 30000,
				temperature = 0,
				max_tokens = 4096,
			},
		},
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		"ColinKennedy/mega.logging",
		"ColinKennedy/mega.cmdparse",
	},
}
