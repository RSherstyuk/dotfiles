require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		java = {},
    sql = {"sqruff"}
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({
		async = true,
		lsp_format = "fallback",
		timeout_ms = 2000,
	})
end, {
	desc = "Форматировать текущий файл",
})

-- Автоформат при сохранении
-- vim.api.nvim_create_autocmd("BufWritePre", {
--
-- 	pattern = "*",
-- 	callback = function(args)
-- 		require("conform").format({
-- 			bufnr = args.buf,
--
-- 			async = false,
-- 			lsp_format = "fallback",
-- 			timeout_ms = 2000,
-- 		})
-- 	end,
-- })
