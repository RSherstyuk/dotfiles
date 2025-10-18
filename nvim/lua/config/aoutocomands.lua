-- ==============================
-- Автокоманды
-- ==============================

-- C/C++: Форматирование перед сохранением
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Lua: сохранить и выполнить

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'lua',
	callback = function()
		vim.keymap.set('n', '<C-h>', ':w<CR>:!lua %<CR>', { buffer = true, silent = true })
		vim.keymap.set('i', '<C-h>', '<Esc>:w<CR>:!lua %<CR>', { buffer = true, silent = true })
	end,
})


-- Python: установить colorcolumn и выполнить
vim.api.nvim_create_autocmd('FileType', {

	pattern = 'python',
	callback = function()
		vim.opt.colorcolumn = '88'
		vim.keymap.set('n', '<C-h>', ':w<CR>:!python3 %<CR>', { buffer = true, silent = true })

		vim.keymap.set('i', '<C-h>', '<Esc>:w<CR>:!python3 %<CR>', { buffer = true, silent = true })
	end,
})

-- C: скомпилировать и выполнить
vim.api.nvim_create_autocmd('FileType', {

	pattern = 'c',
	callback = function()
		vim.keymap.set('n', '<C-h>', ':w<CR>:!gcc % -o out; ./out<CR>', { buffer = true, silent = true })
		vim.keymap.set('i', '<C-h>', '<Esc>:w<CR>:!gcc % -o out; ./out<CR>', { buffer = true, silent = true })
	end,
})

-- Shell и Go: сохранить и выполнить
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'sh', 'go' },
	callback = function()
		vim.keymap.set('n', '<C-h>', ':w<CR>:!%<CR>', { buffer = true, silent = true })
		vim.keymap.set('i', '<C-h>', '<Esc>:w<CR>:!%<CR>', { buffer = true, silent = true })
	end,
})


-- Java: скомпилировать и выполнить
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'java',
	callback = function()
		vim.keymap.set('n', '<C-h>', ':w<CR>:!javac % && java %:r<CR>', { buffer = true, silent = true })
		vim.keymap.set('i', '<C-h>', '<Esc>:w<CR>:!javac % && java %:r<CR>', { buffer = true, silent = true })
	end,
})
