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
vim.g.mapleader = ','
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
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
vim.keymap.set('n', ',<Space>', ':nohlsearch<CR>', { noremap = true })
vim.keymap.set('n', 'H', 'gT', { noremap = true })
vim.keymap.set('n', 'L', 'gt', { noremap = true })
vim.keymap.set('n', ',f', ':Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', ',g', ':Telescope live_grep<CR>', { noremap = true })
vim.keymap.set('n', 'gw', ':bp|bd #<CR>', { noremap = true, silent = true })

-- Git через Telescope
vim.keymap.set('n', ',gb', ':Telescope git_branches<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ',gc', ':Telescope git_commits<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ',gs', ':Telescope git_status<CR>', { noremap = true, silent = true })

require('config.aoutocomands')

-- ==============================
-- Плагины (packer)
-- ==============================
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'

	-- Mason - менеджер LSP, линтеров и форматтеров

	use {

		'williamboman/mason.nvim',

		config = function()
			require('mason').setup()
		end
	}
	use {
		'williamboman/mason-lspconfig.nvim',

		config = function()
			require('mason-lspconfig').setup({
				ensure_installed = { 'jdtls', 'pyright', 'rust_analyzer', 'clangd' },
				automatic_installation = true,
			})
		end
	}


	--JAVA
	use 'mfussenegger/nvim-jdtls'


	use 'nvim-tree/nvim-web-devicons'

	use 'MunifTanjim/nui.nvim'

	-- Neo-tree: оставляем только use и branch

	use {
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		-- dependencies, config, и ключи теперь будут в отдельном файле (или в этом, но в отдельном блоке)
	}

	-- Gemini AI интеграция
	use {
		'David-Kunz/gen.nvim',
		config = function()
			require('gen').setup({
				model = "gemini-2.5-flash", -- или другая модель Gemini
				host = 'generativelanguage.googleapis.com',
				port = '443',
				path = '/v1beta/models/',
				-- Дополнительные настройки...
			})
		end
	}

	use {
		'L3MON4D3/LuaSnip',
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
		end
	}
	-- Syntax highlight
	use 'nvim-treesitter/nvim-treesitter'

	-- Themes
	use 'morhetz/gruvbox'
	use 'ayu-theme/ayu-vim'
	use 'sainnhe/gruvbox-material'
	use 'rebelot/kanagawa.nvim'

	-- Comments
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup({
				padding = true,
				toggler = { line = ',cc', block = ',cb' },
				opleader = { line = ',c', block = ',b' },
			})
		end
	}

	-- Telescope
	use 'nvim-telescope/telescope.nvim'
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	-- Utils
	use 'Pocco81/auto-save.nvim'
	use 'mfussenegger/nvim-lint'
	use 'stevearc/conform.nvim'

	-- Git плагины
	use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use 'nvim-lualine/lualine.nvim'

	-- Jupyter / Python Notebooks
	use {
		"GCBallesteros/jupytext.nvim",
		config = function()
			require("jupytext").setup({
				style = "hydrogen",
				output_extension = "ipynb",
				force_ft = "python",
			})
		end
	}

	use {
		"benlubas/molten-nvim",
		run = ":UpdateRemotePlugins",
		config = function()
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_open_output = true
		end
	}
end)

-- ==============================
-- Neo-tree
-- ==============================
require("neo-tree.command").execute({ action = "close" })
local api = vim.api
api.nvim_set_keymap('n', '<leader>d', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = 'Toggle Neo-tree' })

-- ==============================
-- Цветовая схема
-- ==============================
vim.cmd([[colorscheme kanagawa-dragon]])

-- ==============================
-- LSP НАСТРОЙКА
-- ==============================
-- Инициализация Mason

require('mason').setup()
require('mason-lspconfig').setup({

	ensure_installed = { 'pyright', 'rust_analyzer', 'clangd' },
	automatic_installation = true,
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)

	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
end

-- Включаем отображение текста ошибок
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})


-- Настройка LSP серверов вручную
lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		['rust-analyzer'] = {
			cargo = { allFeatures = true },
			procMacro = { enable = true },
		},
	},
})

lspconfig.clangd.setup({
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=never",
		"--all-scopes-completion"

	},

	filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
	single_file_support = true,
	on_attach = on_attach,
})

-- Серверы
lspconfig.lua_ls.setup({
	cmd = {
		os.getenv("HOME") .. "/.local/share/nvim/lsp_servers/bin/lua-language-server"
	},
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- ==============================
-- JAVA LSP IMPORT
-- ==============================
local jdtls_config = require('config.java') -- 'config.jdtls' соответствует lua/config/jdtls.lua

-- conform.nvim (форматтеры)
-- ==============================
require("conform").setup({

	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		javascript = { "prettier" },
		c = { "clang-format" },
		cpp = { "clang-format" },
	},

})


-- ==============================
-- nvim-lint (линтеры)
-- ==============================
require("lint").linters_by_ft = {
	python = { "flake8" },
	javascript = { "eslint_d" },
	sh = { "shellcheck" },
	java = { "checkstyle" }, -- или "pmd"
	lua = { "luacheck" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

-- Остальная часть конфигурации остается без изменений...
-- ==============================
-- Telescope
-- ==============================
require('telescope').setup({

	defaults = {
		file_ignore_patterns = { "%.pyc$", "__pycache__/", "%.pyo$", "%.class$", "build/", "target/" },
	},
})
require('telescope').load_extension('fzf')

-- ==============================
-- Auto-save
-- ==============================
require('auto-save').setup()

-- ==============================
-- nvim-cmp
-- ==============================
local cmp = require('cmp')
cmp.setup({
	completion = { autocomplete = false },
	mapping = {
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<Up>'] = cmp.mapping.select_prev_item(),
		['<Down>'] = cmp.mapping.select_next_item(),

	},
	sources = cmp.config.sources({ { name = 'nvim_lsp' } }),
})

-- ==============================
-- Transparent background
-- ==============================
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])


-- ==============================
-- LuaSnip settings
-- ==============================
require("luasnip").config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI"
}

-- Настройка gitsigns.nvim
require('gitsigns').setup {
	signs = {
		add          = { hl = 'GitGutterAdd', text = '+' },
		change       = { hl = 'GitGutterChange', text = '~' },
		delete       = { hl = 'GitGutterDelete', text = '_' },
		topdelete    = { hl = 'GitGutterDeleteChange', text = '‾' },
		changedelete = { hl = 'GitGutterChange', text = '~' },
	},
	current_line_blame = false,
}

-- Настройка lualine для ветки git
require('lualine').setup {
	options = {
		theme = 'gruvbox',
		section_separators = '',
		component_separators = ''
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	}
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.ipynb",
	callback = function()
		if vim.fn.executable("jupytext") == 1 then
			vim.cmd("JupytextLoad")
		else
			vim.notify("jupytext (Python) is not installed! Run `pip install jupytext`.", vim.log.levels.ERROR)
		end
	end,

})

-- Горячие клавиши для работы с ячейками (Molten)
vim.keymap.set("n", "<leader>rr", ":MoltenEvaluateLine<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>rr", ":<C-u>MoltenEvaluateVisual<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>rc", ":MoltenEvaluateCell<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ra", ":MoltenEvaluateBuffer<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ro", ":MoltenShowOutput<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>rk", ":MoltenRestart<CR>", { noremap = true, silent = true })
