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
