return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewFileHistory",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewRefresh",
	},
	opts = {
		enhanced_diff_hl = true,
		use_icons = true,
		view = {
			default = { layout = "diff2_horizontal", winbar_info = true },
			file_history = { layout = "diff2_horizontal", winbar_info = true },
		},
		file_panel = {
			listing_style = "tree",
			win_config = { position = "left", width = 35 },
		},
	},
}
