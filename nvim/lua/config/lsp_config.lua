-- lua/lsp_config.lua
local M = {}

M.setup = function()
	-- ==============================
	-- Настройка LSP
	-- ==============================
	local lspconfig = require("lspconfig")
	-- Убедитесь, что 'cmp_nvim_lsp' установлен, если вы его используете.

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	local on_attach = function(_, bufnr)
		local opts = { buffer = bufnr, noremap = true, silent = true }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end

	-- Включаем отображение текста ошибок
	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
	})

	-- Серверы
	lspconfig.lua_ls.setup({
		cmd = {
			"/home/xyz/.local/share/nvim/lsp_servers/lua_lsp/bin/lua-language-server",
		},
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
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

	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			python = {
				pythonPath = "./.venv/bin/python",
				venvPath = "./",
				venv = ".venv",
			},
		},
	})

	lspconfig.gopls.setup({
		capabilities = capabilities,
		on_attach = on_attach,

		filetypes = { "go", "gomod", "gowork", "gohtmltmpl" },
		settings = {
			gopls = {
				completeUnimported = true,

				gofumpt = true,

				analyses = {
					unusedparams = true,
					shadow = true,
				},

				-- Настройка для показа встроенных подсказок (Inlay Hints)
				-- inlayHints = {
				--     -- Например, для показа типов в объявлениях переменных
				--     assignVariableTypes = true,
				--     constantValues = true,
				-- },

				buildFlags = { "-tags=wireinject" },
			},
		},
	})

	lspconfig.ts_ls.setup({ capabilities = capabilities, on_attach = on_attach })

	lspconfig.clangd.setup({ capabilities = capabilities, on_attach = on_attach })

	lspconfig.neocmake.setup({
		cmd = { vim.fn.stdpath("data") .. "/lsp_servers/neocmake/neocmakelsp-x86_64-unknown-linux-gnu", "--stdio" },
		filetypes = { "cmake" },
		root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".git"),
	})

	lspconfig.bashls.setup({ capabilities = capabilities, on_attach = on_attach })
end

return M
