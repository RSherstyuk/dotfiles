-- Файл: lua/config/neo-tree.lua
require("neo-tree").setup({
	-- 1. Определяем, какие "источники" будут доступны
	sources = { "filesystem", "buffers", "git_status" },

	-- 2. Настройки файловой системы
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

	-- 3. Настройки окна (внешний вид и привязки)

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

			["H"] = "toggle_hidden",

			["t"] = "open_in_tab",
			["P"] = { "toggle_preview", config = { use_float = false } },
		},
	},

	-- 4. Автоматическое закрытие и относительные номера строк
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
				vim.opt_local.relativenumber = true -- Включаем relativenumber
			end,
		},
	},
})
