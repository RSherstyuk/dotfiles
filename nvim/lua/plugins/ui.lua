return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				transparent = true,
				overrides = function(colors)
					return {
						Normal = { bg = "NONE" },
						NormalFloat = { bg = "NONE" },
						LineNr = { bg = "NONE" },
						SignColumn = { bg = "NONE" },
						StatusLine = { bg = "NONE" },
						EndOfBuffer = { bg = "NONE" },
					}
				end,
			})
		end,
	},
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

-- require('kanagawa').setup({
--     overrides = function(colors)
--         return {
--             -- Делаем основной фон абсолютно черным
--             Normal = { bg = "#000000" },
--             -- Для плавающих окон (подсказки, диагностика)
--             NormalFloat = { bg = "#000000" },

--             -- Фон для строк с номерами
--             LineNr = { bg = "#000000" },

--             SignColumn = { bg = "#000000" },
--             -- Статусная строка (если хотите тоже черную)
--             StatusLine = { bg = "#000000" },
--         }
--     end,
-- })
