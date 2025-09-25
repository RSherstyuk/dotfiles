-- ==============================
-- Общие настройки
-- ==============================
vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.number = true
vim.opt.cursorline = false
vim.opt.swapfile = false
vim.opt.scrolloff = 7
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.fileformat = "unix"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.g.mapleader = ','

-- ==============================
-- Keymaps
-- ==============================
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
vim.keymap.set('n', ',<Space>', ':nohlsearch<CR>', { noremap = true })
vim.keymap.set('n', 'H', 'gT', { noremap = true })
vim.keymap.set('n', 'L', 'gt', { noremap = true })
vim.keymap.set('n', ',f', ':Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', ',g', ':Telescope live_grep<CR>', { noremap = true })
vim.keymap.set('n', 'gw', ':bp|bd #<CR>', { noremap = true, silent = true })

-- ==============================
-- NETRW
-- ==============================
vim.keymap.set('n', '<leader>d', function()
  if vim.bo.filetype == 'netrw' then
    vim.cmd('q')
  else
    vim.cmd('Vex')
  end
end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    vim.keymap.set('n', '<leader>q', ':q<CR>', { buffer = true, noremap = true, silent = true })
  end,
})

-- ==============================
-- Автокоманды
-- ==============================
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Python
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt.colorcolumn = '88'
    vim.keymap.set('n', '<C-h>', ':w<CR>:!python3 %<CR>', { buffer = true, silent = true })
    vim.keymap.set('i', '<C-h>', '<Esc>:w<CR>:!python3 %<CR>', { buffer = true, silent = true })
  end,
})

-- C
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'c',
  callback = function()
    vim.keymap.set('n', '<C-h>', ':w<CR>:!gcc % -o out; ./out<CR>', { buffer = true, silent = true })
    vim.keymap.set('i', '<C-h>', '<Esc>:w<CR>:!gcc % -o out; ./out<CR>', { buffer = true, silent = true })
  end,
})

-- Shell и Go
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'sh', 'go' },
  callback = function()
    vim.keymap.set('n', '<C-h>', ':w<CR>:!%<CR>', { buffer = true, silent = true })
    vim.keymap.set('i', '<C-h>', '<Esc>:w<CR>:!%<CR>', { buffer = true, silent = true })
  end,
})

-- ==============================
-- Плагины (packer)
-- ==============================
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'

  -- LSP / Completion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'

  -- Snippets
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      local ls = require("luasnip")
      require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
      vim.keymap.set({"i", "s"}, "<Tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          return "<Tab>"
        end
      end, { expr = true, silent = true })
      vim.keymap.set({"i", "s"}, "<S-Tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end
  }

  -- Syntax highlight
  use 'nvim-treesitter/nvim-treesitter'

  -- Themes
  use 'morhetz/gruvbox'
  use 'ayu-theme/ayu-vim'
  use 'sainnhe/gruvbox-material'
  use 'rebelot/kanagawa.nvim'

  -- Comments
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        padding = true,
        toggler = { line = ',cc', block = ',cb' },
        opleader = { line = ',c', block = ',b' },
      })
    end
  }

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Utils
  use 'Pocco81/auto-save.nvim'
  -- use 'jose-elias-alvarez/null-ls.nvim'

  use 'mfussenegger/nvim-lint'
  use 'stevearc/conform.nvim'
end)

-- ==============================
-- Цветовая схема
-- ==============================
vim.cmd([[colorscheme kanagawa-dragon]])

-- ==============================
-- Настройка LSP
-- ==============================
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
end

-- Включаем отображение текста ошибок
vim.diagnostic.config({
  virtual_text = true,  -- Показывать текст ошибок справа от строки
  signs = true,         -- Оставлять значки (E, W и т.д.)
  underline = true,     -- Подчёркивать ошибочный текст
  update_in_insert = false,
  severity_sort = true,
})


-- Серверы
lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.tsserver.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.gopls.setup({
  cmd = { "gopls" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } }
})
lspconfig.rust_analyzer.setup({
  cmd = { "rust-analyzer" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = { ["rust-analyzer"] = { cargo = { allFeatures = true }, procMacro = { enable = true } } }
})
lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never", "--all-scopes-completion" },
  filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
  single_file_support = true,
})

-- ==============================
-- Null-ls
-- ==============================
-- require('null-ls').setup({
--   sources = {
--     require('null-ls').builtins.formatting.prettier,
--     require('null-ls').builtins.formatting.clang_format,
--   }
-- })


-- ==============================
-- conform.nvim (форматтеры)

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    javascript = { "prettier" },
    c = { "clang-format" },
    cpp = { "clang-format" },
  },
})

-- авто-формат при сохранении
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})


vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  callback = function(args)
    -- sync поведение (async = false) — чтобы файл был отформатирован до записи, как раньше
    require("conform").format({ bufnr = args.buf, async = false, lsp_format = "fallback", timeout_ms = 2000 })
  end,
})

-- nvim-lint (линтеры)
require("lint").linters_by_ft = {
  python = { "flake8" },
  javascript = { "eslint_d" },
  sh = { "shellcheck" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
-- ==============================

-- ==============================
-- Telescope
-- ==============================
require('telescope').setup({
  defaults = {
    file_ignore_patterns = { "%.pyc$", "__pycache__/", "%.pyo$" },
  },
})
require('telescope').load_extension('fzf')

-- ==============================
-- Auto-save
-- ==============================
require('auto-save').setup()

-- ==============================
-- Clipboard
-- ==============================
vim.g.clipboard = {
  name = 'xclip',
  copy = { ['+'] = 'xclip -selection clipboard', ['*'] = 'xclip -selection clipboard' },
  paste = { ['+'] = 'xclip -selection clipboard -o', ['*'] = 'xclip -selection clipboard -o' },
  cache_enabled = 1,
}

-- ==============================
-- nvim-cmp
-- ==============================
local cmp = require('cmp')
cmp.setup({
  completion = { autocomplete = false },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
  },
  sources = cmp.config.sources({ { name = 'nvim_lsp' } }),
})

-- ==============================
-- Transparent background (optional)
-- ==============================
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])

-- ==============================
-- LuaSnip settings
-- ==============================
require("luasnip").config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI"
}

