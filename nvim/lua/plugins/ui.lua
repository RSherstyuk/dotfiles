return {
	{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
	{ "nvim-lualine/lualine.nvim" },
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<C-t>]],
				direction = "float",
				float_opts = { border = "curved" },
			})
		end,
	},
}
