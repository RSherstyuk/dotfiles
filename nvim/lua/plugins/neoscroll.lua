return {
	"karb94/neoscroll.nvim",
	event = "VeryLazy",
	opts = {
		mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
		hide_cursor = true,
		stop_eof = true,
		respect_scrolloff = false,
		cursor_scrolls_alone = true,
		duration_multiplier = 0.5,
		performance_mode = false,
		easing = "sine",
	},
	config = function(_, opts)
		require("neoscroll").setup(opts)

		-- Индивидуальная плавность для конкретных клавиш (duration в мс):
		-- local neoscroll = require("neoscroll")
		-- local map = {
		-- 	["<C-d>"] = function() neoscroll.ctrl_d({ duration = 300 }) end,
		-- 	["<C-u>"] = function() neoscroll.ctrl_u({ duration = 300 }) end,
		-- 	["<C-f>"] = function() neoscroll.ctrl_f({ duration = 400 }) end,
		-- 	["<C-b>"] = function() neoscroll.ctrl_b({ duration = 400 }) end,
		-- }
		-- for key, fn in pairs(map) do
		-- 	vim.keymap.set({ "n", "x" }, key, fn, { silent = true })
		-- end
	end,
}
