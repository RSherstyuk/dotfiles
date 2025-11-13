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

vim.api.nvim_set_keymap('n', '<leader>qq', ':Telescope colorscheme<CR>', { noremap = true })

-- Горячие клавиши для работы с ячейками (Molten)
vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Инициализировать kernel" })
vim.keymap.set("n", "<leader>mr", ":MoltenEvaluateOperator<CR>", { desc = "Выполнить оператор" })
vim.keymap.set("n", "<leader>mrr", ":MoltenEvaluateLine<CR>", { desc = "Выполнить строку" })
vim.keymap.set("v", "<leader>mr", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Выполнить выделение" })
vim.keymap.set("n", "<leader>mp", ":MoltenReevaluateCell<CR>", { desc = "Перезапустить ячейку" })
vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "Удалить kernel" })

-- Настройки Molten
vim.g.molten_image_provider = "image.nvim" -- для отображения изображений
vim.g.molten_output_win_max_height = 12    -- максимальная высота окна вывода
vim.g.molten_auto_open_output = true       -- автоматически открывать окно вывода
vim.g.molten_use_border_highlights = false -- отключить границы

-- ==============================
vim.g.clipboard = {
  name = "win32yank",
  copy = {
    ["+"] = "/home/xyz/bin/win32yank.exe -i --crlf",
    ["*"] = "/home/xyz/bin/win32yank.exe -i --crlf",
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

-- =============================
-- Neo-Tree
-- =============================
require("config.neo-tree")

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
require('kanagawa').setup({
  transparent = true,   -- Важно: включает прозрачность
  theme = "lotus",       -- или "dragon", "lotus"
})

vim.cmd([[colorscheme kanagawa-dragon]])

-- require("catppuccin").setup({
--   flavour = "frappe", -- latte, frappe, macchiato, mocha
--   transparent_background = true,
-- })
--
-- vim.cmd.colorscheme "catppuccin"


-- require("everforest").setup({
--   background = "medium", -- soft, medium, hard
--   transparent_background_level = 1,
-- })
--
-- vim.cmd.colorscheme "everforest"

-- require("onedarkpro").setup({
--   options = { transparency = true },
-- })
--
-- vim.cmd("colorscheme onedark_dark")

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
-- Keymaps
-- ==============================
require("config.keymaps")
