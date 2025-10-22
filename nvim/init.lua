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

vim.cmd([[packadd packer.nvim]])
require("plugins.plugins")

-- ==============================
-- Keymaps
-- ==============================
require("config.keymaps")

-- =============================
-- Neo-Tree
-- =============================
require("config.neo-tree")
require("neo-tree.command").execute({ action = "close" })

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
vim.cmd([[colorscheme kanagawa-dragon]])

-- ==============================
-- LSP
-- ==============================
require("config.lsp_config").setup()

-- -- ==============================
-- -- FORMATTERS & LINTERS
-- -- ==============================
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
-- IPyNB
-- ==============================
require("config.ipy")
