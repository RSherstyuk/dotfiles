-- -- ==============================
-- -- Общие настройки
-- -- ==============================
vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.number = true
vim.opt.cursorline = false
vim.opt.swapfile = false
vim.opt.scrolloff = 7
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
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
		["+"] = "/home/russh/bin/win32yank.exe -i --crlf",
		["*"] = "/home/russh/bin/win32yank.exe -i --crlf",
	},
	paste = {
		["+"] = "/home/russh/bin/win32yank.exe -o --lf",
		["*"] = "/home/russh/bin/win32yank.exe -o --lf",
	},
	cache_enabled = 0,
}
-- ==============================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"

	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	checker = { enabled = true },
})

-- ==============================
-- Keymaps
-- ==============================
require("config.keymaps")

-- =============================
-- Neo-Tree
-- =============================
-- require("config.neo-tree")
-- require("neo-tree.command").execute({ action = "close" })

local api = vim.api
api.nvim_set_keymap(
	"n",
	"<leader>d",
	":Neotree toggle<CR>",
	{ noremap = true, silent = true, desc = "Toggle Neo-tree" }
)

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.o.foldenable = true

-- ==============================
-- Цветовая схема
-- ==============================
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

vim.cmd([[colorscheme kanagawa-dragon]])

-- ==============================
-- LSP
-- ==============================
-- require("config.lsp_config").setup()
-- Безопасная загрузка LSP
local status_ok, lsp_config = pcall(require, "config.lsp_config")
if status_ok then
	lsp_config.setup()
end

-- -- ==============================
-- -- FORMATTERS & LINTERS
-- -- ==============================
require("config.formatters")
-- require("config.linters")

-- ==============================
-- Java
-- ==============================
-- local jdtls_config_success, jdtls_config = pcall(require, "config.java")
-- if jdtls_config_success and jdtls_config.setup then
-- 	jdtls_config.setup()
-- end

-- ==============================
-- Auto-save
-- ==============================
-- require("auto-save").setup()

-- ==============================
-- nvim-cmp
-- ==============================
-- require("config.cmp")

-- ==============================
-- Настройка gitsigns.nvim
-- ==============================
-- require("config.git")
