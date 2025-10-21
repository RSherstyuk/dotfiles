-- ==============================
-- Плагины (packer)
-- ==============================
local use = require("packer").use

local dap_plugins = require("plugins.dap")
local mason_tool = require("plugins.mason-tool")
local mason = require("plugins.mason")

require("packer").startup(function()
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip")

	--JAVA
	use("mfussenegger/nvim-jdtls")
	use("tpope/vim-dispatch")

	--------------------------------------------------
	-- 1. Добавление плагинов из dap.lua
	--------------------------------------------------
	for _, plugin in ipairs(dap_plugins) do
		use(plugin)
	end
	--------------------------------------------------

	for _, plugin in ipairs(mason_tool) do
		use(plugin)
	end

	for _, plugin in ipairs(mason) do
		use(plugin)
	end

	use("nvim-tree/nvim-web-devicons")

	use("MunifTanjim/nui.nvim")

	use({
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<C-t>]], -- Замените на удобную для вас комбинацию
				direction = "float", -- 'float' для плавающего, 'vertical' или 'horizontal' для сплита
				float_opts = {
					border = "curved",
				},
			})
			-- Установка горячей клавиши для переключения (если не указано в open_mapping)
			vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
		end,
	})

	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- Важно, чтобы этот плагин был в зависимостях

			"MunifTanjim/nui.nvim",
		},
	})

	use({
		"L3MON4D3/LuaSnip",

		config = function()
			local ls = require("luasnip")

			require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })

			-- Используем отдельные клавиши вместо Tab чтобы избежать конфликтов
			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })
		end,
	})

	-- Tree-sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	})

	-- UFO (умный фолдинг)
	use({
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
		config = function()
			require("config.ufo")
		end,
	})

	-- Themes
	use("morhetz/gruvbox")
	use("ayu-theme/ayu-vim")
	use("sainnhe/gruvbox-material")

	use("rebelot/kanagawa.nvim")

	-- Comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				padding = true,
				toggler = { line = ",cc", block = ",cb" },

				opleader = { line = ",c", block = ",b" },
			})
		end,
	})

	--Telescope
	use("nvim-telescope/telescope.nvim")

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Utils
	use("Pocco81/auto-save.nvim")
	use("mfussenegger/nvim-lint")

	use("stevearc/conform.nvim")

	-- Git плагины
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("nvim-lualine/lualine.nvim")

	-- Jupyter / Python Notebooks
	use({
		"GCBallesteros/jupytext.nvim",
		config = function()
			require("jupytext").setup({
				style = "hydrogen",
				output_extension = "ipynb",
				force_ft = "python",
			})
		end,
	})

	use({
		"benlubas/molten-nvim",
		run = ":UpdateRemotePlugins",
		config = function()
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_open_output = true
		end,
	})
end)
