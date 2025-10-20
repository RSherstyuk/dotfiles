-- ==============================
-- Keymaps
-- ==============================

vim.keymap.set("n", "<leader>e", ":Neotree toggle reveal<CR>", { desc = "Toggle Neo-tree and Reveal File" })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set("n", ",<Space>", ":nohlsearch<CR>", { noremap = true })
vim.keymap.set("n", "H", "gT", { noremap = true })
vim.keymap.set("n", "L", "gt", { noremap = true })

vim.keymap.set("n", ",f", ":Telescope find_files<CR>", { noremap = true })
vim.keymap.set("n", ",g", ":Telescope live_grep<CR>", { noremap = true })
vim.keymap.set("n", "gw", ":bp|bd #<CR>", { noremap = true, silent = true })

-- Git через Telescope
vim.keymap.set("n", ",gb", ":Telescope git_branches<CR>", { noremap = true, silent = true })
vim.keymap.set("n", ",gc", ":Telescope git_commits<CR>", { noremap = true, silent = true })
vim.keymap.set("n", ",gs", ":Telescope git_status<CR>", { noremap = true, silent = true })
