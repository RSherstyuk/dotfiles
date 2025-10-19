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
