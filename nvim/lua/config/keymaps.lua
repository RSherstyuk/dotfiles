-- ==============================
-- Keymaps
-- ==============================
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("i", "jk", "<Esc>", { noremap = true })
keymap("n", ",<Space>", ":nohlsearch<CR>", { noremap = true })
keymap("n", "H", "gT", { noremap = true })
keymap("n", "L", "gt", { noremap = true })

keymap("n", ",ff", ":Telescope find_files<CR>", { noremap = true })
keymap("n", ",g", ":Telescope live_grep<CR>", { noremap = true })
keymap("n", "gw", ":bp|bd #<CR>", { noremap = true, silent = true })

-- Git with Telescope
keymap("n", ",gb", ":Telescope git_branches<CR>", { noremap = true, silent = true })
keymap("n", ",gc", ":Telescope git_commits<CR>", { noremap = true, silent = true })
keymap("n", ",gs", ":Telescope git_status<CR>", { noremap = true, silent = true })

keymap("n", "<leader>e", ":Neotree toggle reveal<CR>", { desc = "Toggle Neo-tree and Reveal File" })

-- Фолдинг
keymap("n", "<leader>zR", "zR", opts) -- раскрыть все
keymap("n", "<leader>zM", "zM", opts) -- свернуть все
keymap("n", "<leader>za", "za", opts) -- переключить текущий
keymap("n", "<leader>zo", "zo", opts) -- открыть текущий
keymap("n", "<leader>zc", "zc", opts) -- закрыть текущий
