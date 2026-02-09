require("neo-tree").setup({
	sources = { "filesystem", "buffers", "git_status" },
	filesystem = {
		bind_to_cwd = true,

		follow_current_file = {
			enabled = true,
			auto_open_detect = false,
		},
		filtered_items = {
			hide_dotfiles = true,

			hide_gitignored = true,
			never_show = {
				".DS_Store",
				"thumbs.db",
				"node_modules",
			},
		},
	},
	window = {
		position = "left",
		width = 35,
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
			["<cr>"] = "open",
			["A"] = "add_directory",
			["a"] = { "add", config = { show_path = "none" } },
			["d"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["p"] = "paste_from_clipboard",
			["q"] = "toggle_hidden",
			["v"] = "open_vsplit",
			["s"] = "open_split",

			["t"] = "open_tabnew",
			["P"] = { "toggle_preview", config = { use_float = false } },
		},
	},

	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function()
				vim.opt_local.relativenumber = true
			end,
		},
		{
			event = "neo_tree_buffer_enter",
			handler = function()
				vim.opt_local.relativenumber = true
			end,
		},
	},
})
