-- ==============================
-- Настройка Java LSP (jdtls) для SDKMAN (СКОРРЕКТИРОВАНО ДЛЯ РУЧНОЙ УСТАНОВКИ)
-- ==============================

local jdtls = require("jdtls")
local M = {}

function M.setup()
	local home = os.getenv("HOME")

	local cmp_installed, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if cmp_installed then
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	end

	local jdtls_root = home .. "/.local/share/nvim/lsp_servers/jdtls"
	local jdtls_dir = jdtls_root -- Теперь jdtls_dir ссылается на правильный корень

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

	local function setup_jdtls()
		local launcher_jar = vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar")

		if launcher_jar == "" then
			vim.notify(
				"JDTLS не найден! Проверьте путь или выполните :MasonInstall jdtls",
				vim.log.levels.WARN
			)
			return false
		end

		local config_dir = jdtls_dir .. "/config_linux"
		local workspace_dir = home .. "/.cache/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

		local jdtls_config = {
			cmd = {
				"/home/xyyz/.sdkman/candidates/java/current/bin/java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx4G",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-jar",
				launcher_jar,

				"-configuration",
				config_dir,
				"-data",
				workspace_dir,
			},

			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				java = {
					configuration = {

						runtimes = {
							{

								name = "JavaSE-24",
								path = "/home/xyyz/.sdkman/candidates/java/24.0.2-librca",
							},
							{
								name = "JavaSE-21",
								path = "/home/xyyz/.sdkman/candidates/java/21.0.8-librca",
							},
							{
								name = "JavaSE-current",
								path = "/home/xyyz/.sdkman/candidates/java/current",
							},
						},
					},
				},
			},
		}

		jdtls.start_or_attach(jdtls_config)
		return true
	end

	-- Запуск jdtls при открытии Java файлов
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		callback = function()
			setup_jdtls()
		end,
	})

	-- Ключевые связки для Java (оставлены без изменений)
	vim.api.nvim_create_autocmd("FileType", {

		pattern = "java",
		callback = function()
			local opts = { buffer = true, silent = true }

			vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)
			vim.keymap.set("n", "<leader>jt", jdtls.test_class, opts)

			vim.keymap.set("n", "<leader>jT", jdtls.test_nearest_method, opts)

			vim.keymap.set("x", "<leader>je", '<Esc><CMD>lua require("jdtls").extract_variable(true)<CR>', opts)

			vim.keymap.set("n", "<leader>je", '<CMD>lua require("jdtls").extract_variable()<CR>', opts)

			vim.keymap.set("x", "<leader>jm", '<Esc><CMD>lua require("jdtls").extract_method(true)<CR>', opts)

			vim.keymap.set("n", "<leader>jc", jdtls.compile, opts)
		end,
	})
end

return M
