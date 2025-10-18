-- ============================

-- ЛИНТЕРЫ (nvim-lint)
-- ============================

local lint = require("lint")

lint.linters_by_ft = {
	-- lua = { "luacheck" },
	python = { "pylint" },

	javascript = { "eslint_d" },

	java = { "checkstyle" },

	-- c = { "clangtidy" },
	-- cpp = { "clangtidy" },
}

-- Автоматически запускать линтер при сохранении
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

-- Добавляем установку линтеров в Mason Tool Installer
require("mason-tool-installer").setup({
	ensure_installed = {
		"pylint",
		"eslint_d",
		"checkstyle",
		-- "luacheck",
		-- "clang-tidy",
	},
})

-- Дополнительно: делаем диагностику более читаемой
vim.diagnostic.config({
	virtual_text = true,
	underline = true,

	signs = true,
	update_in_insert = false,
})
