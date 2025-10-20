-- ==============================
-- Настройка Java LSP
-- ==============================
local Path = require("plenary.path")
local jdtls = require("jdtls")
local core = require("config.core")

local M = {}

local last_java_test_command = nil

-- loads jdks from sdkman.
---@param version string java version to search for
-- This requires java to be installed using sdkman.
local function get_java_dir(version)
	local sdkman_dir = Path.path.home .. "/.sdkman/candidates/java/"
	local java_dirs = vim.fn.readdir(sdkman_dir, function(file)
		if core.string_has_prefix(file, version, true) then
			return 1
		end
	end)

	local java_dir = java_dirs[1]
	if not java_dir then
		error(string.format("No %s java version was found", version))
	end

	return sdkman_dir .. java_dir
end

---gets test name for the node (из исходного конфига)
---@param node TSNode
---@return string?
local function get_test_name(node)
	if node:type() ~= "method_declaration" then
		return
	end

	local name_nodes = node:field("name")
	if #name_nodes == 0 then
		return
	end

	local name_node = name_nodes[1]
	if not name_node then
		return
	end

	local bufnr = vim.api.nvim_get_current_buf()
	return vim.treesitter.get_node_text(name_node, bufnr)
end

function M.setup()
	local home = os.getenv("HOME")

	local capabilities = {}
	local cmp_installed, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if cmp_installed then
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	else
		-- Используем capabilities по умолчанию, если cmp_nvim_lsp не найден
		capabilities = vim.lsp.protocol.make_client_capabilities()
	end

	local jdtls_root = home .. "/.local/share/nvim/lsp_servers/jdtls"
	local jdtls_dir = jdtls_root

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

		-- TODO: Проверь этот путь к lombok.jar. Он может лежать в /plugins/ или в другом месте.
		local lombok_jar = jdtls_dir .. "/bin/lombok.jar"

		-- TODO: Эти пути для ручной установки. Убедись, что бандлы лежат здесь.
		-- Возможно, тебе нужно установить java-debug-adapter и java-test вручную
		-- и прописать пути к их .jar файлам.
		local java_debug_adapter_path = home .. "/.local/share/nvim/lsp_servers/java-debug-adapter"
		local java_test_path = home .. "/.local/share/nvim/lsp_servers/java-test"

		local bundles = vim.iter({
			vim.fn.glob(java_debug_adapter_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1, true),
			vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1, true),
		})
			:flatten()
			:totable()

		-- Добавляем бандлы, только если они найдены
		local init_options_bundles = {}
		for _, bundle_path in ipairs(bundles) do
			if bundle_path and bundle_path ~= "" then
				table.insert(init_options_bundles, bundle_path)
			end
		end

		local config_dir = jdtls_dir .. "/config_linux"
		local workspace_dir = home .. "/.cache/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

		local jdtls_runtime_java_dir = get_java_dir("21")

		local jdtls_config = {
			cmd = {
				jdtls_runtime_java_dir .. "/bin/java", -- <-- ИСПОЛЬЗУЕМ Java 21 ДЛЯ ЗАПУСКА
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx4G",
				"-javaagent:" .. lombok_jar,
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
					home = get_java_dir("21"),
					redhat = {
						telemetry = { enabled = false },
					},
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
					codeGeneration = {
						toString = {
							template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
						},
						hashCodeEquals = {
							useJava7Objects = true,
						},
						useBlocks = true,
					},
					maven = { downloadSources = true },
					compile = {
						nullAnalysis = {
							nonnull = {
								"lombok.NonNull",
								"javax.annotation.Nonnull",
								"org.eclipse.jdt.annotation.NonNull",
								"org.springframework.lang.NonNull",
							},
						},
					},
					eclipse = { downloadSources = true },
					completion = {
						chain = { enabled = false },
						guessMethodArguments = "off",
						favouriteStaticMembers = {
							"org.junit.jupiter.api.Assertions.*",
							"org.junit.jupiter.api.Assumptions.*",
							"org.mockito.Mockito.*",
							"java.util.Objects.*",
						},
					},
					configuration = {
						runtimes = {
							{
								name = "JavaSE-1.8",
								path = get_java_dir("8"),
							},
							{
								name = "JavaSE-11",
								path = get_java_dir("11"),
							},
							{
								name = "JavaSE-17",
								path = get_java_dir("17"),
							},
							{
								name = "JavaSE-21",
								path = get_java_dir("21"),
							},
							{
								name = "JavaSE-23",
								path = get_java_dir("23"),
							},
							{
								name = "JavaSE-25",
								path = get_java_dir("25"),
							},
						},
					},
				},
			},
			init_options = {
				bundles = init_options_bundles,
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

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		callback = function()
			local opts = { buffer = true, silent = true, noremap = true }

			-- === Твои существующие кеймапы ===
			vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)
			vim.keymap.set("n", "<leader>jt", jdtls.test_class, opts)
			vim.keymap.set("n", "<leader>jT", jdtls.test_nearest_method, opts)
			vim.keymap.set("x", "<leader>je", '<Esc><CMD>lua require("jdtls").extract_variable(true)<CR>', opts)
			vim.keymap.set("n", "<leader>je", '<CMD>lua require("jdtls").extract_variable()<CR>', opts)
			vim.keymap.set("x", "<leader>jm", '<Esc><CMD>lua require("jdtls").extract_method(true)<CR>', opts)
			vim.keymap.set("n", "<leader>jc", jdtls.compile, opts)

			-- Кастомные команды для тестов
			vim.keymap.set(
				"n",
				"<localleader>ta",
				"<cmd>JavaTestAll<cr>",
				{ desc = "run test for all packages", buffer = true }
			)
			vim.keymap.set(
				"n",
				"<localleader>tt",
				"<cmd>JavaTestFile<cr>",
				{ desc = "run test for a file", buffer = true }
			)
			vim.keymap.set(
				"n",
				"<localleader>tf",
				"<cmd>JavaTestFunction<cr>",
				{ desc = "run test for a function", buffer = true }
			)
			vim.keymap.set(
				"n",
				"<localleader>tl",
				"<cmd>JavaTestLast<cr>",
				{ desc = "run the last test command again", buffer = true }
			)
			vim.keymap.set(
				"n",
				"<localleader>ot",
				"<cmd>JavaToggleTest<cr>",
				{ desc = "toggle between test and source code", buffer = true }
			)

			-- Встроенные jdtls функции
			vim.keymap.set("n", "<localleader>oi", function()
				jdtls.organize_imports()
			end, { desc = "organize imports", buffer = true })

			vim.keymap.set("n", "<localleader>oa", function()
				jdtls.organize_imports()
				vim.lsp.buf.format()
			end, { desc = "organize all", buffer = true })

			vim.keymap.set("v", "<localleader>ev", function()
				jdtls.extract_variable(true)
			end, { desc = "java extract selected to variable", buffer = true })

			vim.keymap.set("n", "<localleader>ev", function()
				jdtls.extract_variable()
			end, { desc = "java extract variable", buffer = true })

			vim.keymap.set("v", "<localleader>eV", function()
				jdtls.extract_variable_all(true)
			end, { desc = "java extract all selected to variable", buffer = true })

			vim.keymap.set("n", "<localleader>eV", function()
				jdtls.extract_variable_all()
			end, { desc = "java extract all to variable", buffer = true })

			vim.keymap.set("n", "<localleader>ec", function()
				jdtls.extract_constant()
			end, { desc = "java extract constant", buffer = true })

			vim.keymap.set("v", "<localleader>ec", function()
				jdtls.extract_constant(true)
			end, { desc = "java extract selected to constant", buffer = true })

			vim.keymap.set("n", "<localleader>em", function()
				jdtls.extract_method()
			end, { desc = "java extract method", buffer = true })

			vim.keymap.set("v", "<localleader>em", function()
				jdtls.extract_method(true)
			end, { desc = "java extract selected to method", buffer = true })

			vim.keymap.set("n", "<localleader>oT", function()
				local plugin = require("jdtls.tests")
				plugin.goto_subjects()
			end, { desc = "java open test", buffer = true })

			vim.keymap.set("n", "<localleader>ct", function()
				local plugin = require("jdtls.tests")
				plugin.generate()
			end, { desc = "java create test", buffer = true })

			vim.keymap.set("n", "<localleader>dm", function()
				jdtls.test_nearest_method()
			end, { desc = "java debug nearest test method", buffer = true })

			vim.keymap.set("n", "<localleader>dc", function()
				jdtls.test_class()
			end, { desc = "java debug nearest test class", buffer = true })

			vim.keymap.set(
				"n",
				"<localleader>lr",
				"<cmd>JdtWipeDataAndRestart<CR>",
				{ desc = "restart jdtls", buffer = true }
			)
		end,
	})
end

vim.api.nvim_buf_create_user_command(0, "JavaTestAll", function()
	-- Run all tests in the project
	local cmd = "./gradlew test"
	last_java_test_command = cmd
	vim.cmd.Dispatch({ last_java_test_command })
end, {
	desc = "run test for all packages",
})

vim.api.nvim_buf_create_user_command(0, "JavaTestFile", function()
	local cmd = "./gradlew test --tests " .. vim.fn.expand("%:t:r")
	last_java_test_command = cmd
	vim.cmd.Dispatch({ last_java_test_command })
end, {
	desc = "run test for a file",
})

vim.api.nvim_buf_create_user_command(0, "JavaTestFunction", function()
	local cwf = vim.fn.expand("%:.")

	if not string.find(cwf, "Test%.java$") then
		vim.notify("Not a test file")
		return
	end

	local test_name = nil
	local node = vim.treesitter.get_node()
	while node do
		test_name = get_test_name(node)
		if test_name then
			break
		end
		node = node:parent()
	end

	if not test_name then
		vim.notify("Test function was not found")
		return
	end

	local cmd = "./gradlew test --tests " .. vim.fn.expand("%:t:r") .. "." .. test_name
	last_java_test_command = cmd
	vim.cmd.Dispatch({ last_java_test_command })
end, {
	desc = "run test for a function",
})

vim.api.nvim_buf_create_user_command(0, "JavaTestLast", function(opts)
	if last_java_test_command then
		vim.cmd.Dispatch({ last_java_test_command })
	else
		vim.notify("No previous Java test command to run", vim.log.levels.WARN)
	end
end, {
	desc = "run the last test command again",
})

vim.api.nvim_buf_create_user_command(0, "JavaToggleTest", function()
	local cwf = vim.fn.expand("%:.")
	local change_to = cwf
	if string.find(cwf, "/main/java/") then
		change_to = string.gsub(change_to, "/main/java/", "/test/java/")
		change_to = string.gsub(change_to, "(%w+)%.java$", "%1Test.java")
		vim.cmd("edit " .. change_to)
	elseif string.find(cwf, "/test/java/") then
		change_to = string.gsub(change_to, "/test/java/", "/main/java/")
		change_to = string.gsub(change_to, "(%w+)Test%.java$", "%1.java")
		vim.cmd("edit " .. change_to)
	end
end, {
	desc = "toggle between test and source code",
})

return M
