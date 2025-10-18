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
