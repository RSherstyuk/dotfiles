local gitsigns = require("gitsigns")
local lualine = require("lualine")

gitsigns.setup({
	signs = {
		add = { hl = "GitGutterAdd", text = "+" },
		change = { hl = "GitGutterChange", text = "~" },
		delete = { hl = "GitGutterDelete", text = "_" },
		topdelete = { hl = "GitGutterDeleteChange", text = "‾" },
		changedelete = { hl = "GitGutterChange", text = "~" },
	},
	current_line_blame = false,
})

lualine.setup({
	options = {
		theme = "gruvbox",
		section_separators = "",
		component_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },

		lualine_z = { "location" },
	},
})
