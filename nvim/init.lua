-- ==============================
-- Общие настройки
-- ==============================
vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.number = true
vim.opt.cursorline = false
vim.opt.swapfile = false
vim.opt.scrolloff = 7
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.fileformat = "unix"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.g.mapleader = ","
vim.opt.clipboard = "unnamedplus"

-- ==============================
vim.g.clipboard = {
	name = "win32yank",
	copy = {
		["+"] = "/home/xyyz/bin/win32yank.exe -i --crlf",
		["*"] = "/home/xyyz/bin/win32yank.exe -i --crlf",
	},
	paste = {
		["+"] = "/home/xyyz/bin/win32yank.exe -o --lf",
		["*"] = "/home/xyyz/bin/win32yank.exe -o --lf",
	},
	cache_enabled = 0,
}
-- ==============================

-- ==============================
-- Keymaps
-- ==============================
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set("n", ",<Space>", ":nohlsearch<CR>", { noremap = true })
vim.keymap.set("n", "H", "gT", { noremap = true })
vim.keymap.set("n", "L", "gt", { noremap = true })

vim.keymap.set("n", ",f", ":Telescope find_files<CR>", { noremap = true })
vim.keymap.set("n", ",g", ":Telescope live_grep<CR>", { noremap = true })
vim.keymap.set("n", "gw", ":bp|bd #<CR>", { noremap = true, silent = true })

-- ==============================
-- Плагины (packer)
-- ==============================
require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip")

	--JAVA
	use("mfussenegger/nvim-jdtls")

	use("nvim-tree/nvim-web-devicons")
	use("MunifTanjim/nui.nvim")

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
	-- Syntax highlight
	use("nvim-treesitter/nvim-treesitter")

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

-- =============================
-- Neo-Tree
-- =============================
require("neo-tree.command").execute({ action = "close" })

local api = vim.api
api.nvim_set_keymap(
	"n",
	"<leader>d",
	":Neotree toggle<CR>",
	{ noremap = true, silent = true, desc = "Toggle Neo-tree" }
)

-- ==============================
-- Цветовая схема
-- ==============================
vim.cmd([[colorscheme kanagawa-dragon]])

-- ==============================
-- LSP
-- ==============================
require("config.lsp_config").setup()

-- ==============================
-- FORMATTERS & LINTERS
-- ==============================
require("config.formatters")
-- require("config.linters")

-- ==============================
-- Java
-- ==============================
local jdtls_config_success, jdtls_config = pcall(require, "config.java")

if jdtls_config_success and jdtls_config.setup then
	jdtls_config.setup()
end

-- ==============================
-- Auto-save
-- ==============================
require("auto-save").setup()

-- ==============================
-- nvim-cmp
-- ==============================
require("config.cmp")

-- ==============================
-- Настройка gitsigns.nvim
-- ==============================
require("config.git")

-- ==============================
-- IPyNb
-- ==============================
require("config.ipy")
