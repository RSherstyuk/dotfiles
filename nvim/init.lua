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
	change_detection = {
		enabled = false,
		notify = false,
	},
})

require("config.opt")
require("config.keymaps")

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
vim.cmd([[colorscheme kanagawa-dragon]])

-- ==============================
-- LSP
-- ==============================
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
-- gitsigns.nvim
-- ==============================
require("config.git")
