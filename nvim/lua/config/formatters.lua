-- ============================
-- ФОРМАТТЕРЫ (conform.nvim)
-- ============================

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		javascript = { "prettier" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		java = { "google-java-format" },
	},
})

-- Назначение горячей клавиши для форматирования
local function format_file()
	require("conform").format({
		async = true,
		lsp_format = "fallback",
		timeout_ms = 2000,
	})
end

vim.keymap.set({ "n", "v" }, "<leader>f", format_file, {
	desc = "Форматировать текущий файл с помощью conform",
})

-- Автоформат при сохранении
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({
			bufnr = args.buf,
			async = false,
			lsp_format = "fallback",
			timeout_ms = 2000,
		})
	end,
})
