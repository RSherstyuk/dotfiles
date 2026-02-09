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

