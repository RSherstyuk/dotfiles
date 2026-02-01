require("nvim-treesitter").setup({
	-- Устанавливать синхронно (true) или асинхронно (false)
	sync_install = false,

	-- Подсветка синтаксиса
	highlight = {
		enable = true,
	},

	-- Автоотступы
	indent = {
		enable = true,
	},
})
