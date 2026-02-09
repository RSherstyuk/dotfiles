require("nvim-treesitter.install").prefer_git = true

require("nvim-treesitter").setup({
	ensure_installed = {
		"lua",
		"python",
		"bash",
		"json",
		"sql",
		"vim",
		"markdown",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {

		enable = true,
	},
})


