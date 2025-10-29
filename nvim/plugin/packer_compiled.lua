-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/xyz/.cache/nvim/packer_hererocks/2.1.1741730670/share/lua/5.1/?.lua;/home/xyz/.cache/nvim/packer_hererocks/2.1.1741730670/share/lua/5.1/?/init.lua;/home/xyz/.cache/nvim/packer_hererocks/2.1.1741730670/lib/luarocks/rocks-5.1/?.lua;/home/xyz/.cache/nvim/packer_hererocks/2.1.1741730670/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/xyz/.cache/nvim/packer_hererocks/2.1.1741730670/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n£\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\ropleader\1\0\2\tline\a,c\nblock\a,b\ftoggler\1\0\2\tline\b,cc\nblock\b,cb\1\0\3\ropleader\0\ftoggler\0\fpadding\2\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\nO\0\0\2\1\2\0\t-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\3Ä-\0\0\0009\0\1\0B\0\1\1K\0\1\0\0¿\19expand_or_jump\23expand_or_jumpableC\0\0\3\1\2\0\v-\0\0\0009\0\0\0)\2ˇˇB\0\2\2\15\0\0\0X\1\4Ä-\0\0\0009\0\1\0)\2ˇˇB\0\2\1K\0\1\0\0¿\tjump\rjumpableµ\2\1\0\a\0\21\0#6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\t\0006\4\4\0009\4\5\0049\4\6\4'\6\a\0B\4\2\2'\5\b\0&\4\5\4=\4\n\3B\1\2\0016\1\4\0009\1\v\0019\1\f\0015\3\r\0'\4\14\0003\5\15\0005\6\16\0B\1\5\0016\1\4\0009\1\v\0019\1\f\0015\3\17\0'\4\18\0003\5\19\0005\6\20\0B\1\5\0012\0\0ÄK\0\1\0\1\0\1\vsilent\2\0\n<C-k>\1\3\0\0\6i\6s\1\0\1\vsilent\2\0\n<C-j>\1\3\0\0\6i\6s\bset\vkeymap\npaths\1\0\1\npaths\0\14/snippets\vconfig\fstdpath\afn\bvim\14lazy_load\29luasnip.loaders.from_lua\fluasnip\frequire\0" },
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["auto-save.nvim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/auto-save.nvim",
    url = "https://github.com/Pocco81/auto-save.nvim"
  },
  ["ayu-vim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/ayu-vim",
    url = "https://github.com/ayu-theme/ayu-vim"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["conform.nvim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/conform.nvim",
    url = "https://github.com/stevearc/conform.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  ["kanagawa.nvim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-tool-installer.nvim"] = {
    config = { "\27LJ\2\n·\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\0\2\21ensure_installed\0\16start_delay\3\0\1\t\0\0\bbuf\15checkstyle\23java-debug-adapter\14java-test\njdtls\15kotlin-lsp\24lua-language-server\14protolint\nsetup\25mason-tool-installer\frequire\0" },
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/mason-tool-installer.nvim",
    url = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n≤\1\0\0\6\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\5\0005\5\4\0=\5\6\4=\4\a\3B\1\2\1K\0\1\0\aui\nicons\1\0\1\nicons\0\1\0\3\24package_uninstalled\b‚úó\20package_pending\b‚ûú\22package_installed\b‚úì\1\0\2\aui\0\tPATH\vappend\nsetup\nmason\frequire\0" },
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neo-tree.nvim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\n#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\14terminate\"\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\rcontinue'\0\0\2\1\2\0\5-\0\0\0009\0\0\0009\0\1\0B\0\1\1K\0\1\0\0¿\topen\trepl'\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\18run_to_cursor#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\14step_over#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\14step_into\"\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\rstep_out+\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\22toggle_breakpointd\0\0\4\1\5\0\n6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2-\1\0\0009\1\4\1\18\3\0\0B\1\2\1K\0\1\0\0¿\19set_breakpoint\27Breakpoint condition: \ninput\afn\bvim≤\5\1\0\a\0#\0R6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\b\0003\5\t\0005\6\n\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\v\0003\5\f\0005\6\r\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\14\0003\5\15\0005\6\16\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\17\0003\5\18\0005\6\19\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\20\0003\5\21\0005\6\22\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\23\0003\5\24\0005\6\25\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\26\0003\5\27\0005\6\28\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\29\0003\5\30\0005\6\31\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4 \0003\5!\0005\6\"\0B\1\5\0012\0\0ÄK\0\1\0\1\0\1\tdesc(Toggle Debug conditional Breakpoint\0\15<leader>DB\1\0\1\tdesc\28Toggle Debug breakpoint\0\15<leader>Db\1\0\1\tdesc\rStep out\0\n<F12>\1\0\1\tdesc\14Step into\0\n<F11>\1\0\1\tdesc\14Step over\0\n<F10>\1\0\1\tdesc\28Run debugging to cursor\0\t<F7>\1\0\1\tdesc\14Open REPL\0\t<F6>\1\0\1\tdesc\23Continue debugging\0\t<F5>\1\0\1\tdesc\19Stop debugging\0\t<F2>\6n\bset\vkeymap\bvim\nsetup\26nvim-dap-virtual-text\bdap\frequire\0" },
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-jdtls"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/nvim-jdtls",
    url = "https://github.com/mfussenegger/nvim-jdtls"
  },
  ["nvim-lint"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/nvim-lint",
    url = "https://github.com/mfussenegger/nvim-lint"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22config.treesitter\frequire\0" },
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ufo"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15config.ufo\frequire\0" },
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/nvim-ufo",
    url = "https://github.com/kevinhwang91/nvim-ufo"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["promise-async"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\nÅ\2\0\0\6\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\1K\0\1\0\1\0\1\tdesc\20Toggle terminal\24<cmd>ToggleTerm<cr>\15<leader>tt\6n\bset\vkeymap\bvim\15float_opts\1\0\1\vborder\vcurved\1\0\4\15float_opts\0\14direction\nfloat\17open_mapping\n<C-t>\tsize\3\20\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["typescript-language-server"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/typescript-language-server",
    url = "https://github.com/typescript-language-server/typescript-language-server"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/xyz/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\nÅ\2\0\0\6\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\1K\0\1\0\1\0\1\tdesc\20Toggle terminal\24<cmd>ToggleTerm<cr>\15<leader>tt\6n\bset\vkeymap\bvim\15float_opts\1\0\1\vborder\vcurved\1\0\4\15float_opts\0\14direction\nfloat\17open_mapping\n<C-t>\tsize\3\20\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: mason-tool-installer.nvim
time([[Config for mason-tool-installer.nvim]], true)
try_loadstring("\27LJ\2\n·\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\0\2\21ensure_installed\0\16start_delay\3\0\1\t\0\0\bbuf\15checkstyle\23java-debug-adapter\14java-test\njdtls\15kotlin-lsp\24lua-language-server\14protolint\nsetup\25mason-tool-installer\frequire\0", "config", "mason-tool-installer.nvim")
time([[Config for mason-tool-installer.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n£\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\ropleader\1\0\2\tline\a,c\nblock\a,b\ftoggler\1\0\2\tline\b,cc\nblock\b,cb\1\0\3\ropleader\0\ftoggler\0\fpadding\2\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-ufo
time([[Config for nvim-ufo]], true)
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15config.ufo\frequire\0", "config", "nvim-ufo")
time([[Config for nvim-ufo]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\n#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\14terminate\"\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\rcontinue'\0\0\2\1\2\0\5-\0\0\0009\0\0\0009\0\1\0B\0\1\1K\0\1\0\0¿\topen\trepl'\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\18run_to_cursor#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\14step_over#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\14step_into\"\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\rstep_out+\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\22toggle_breakpointd\0\0\4\1\5\0\n6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2-\1\0\0009\1\4\1\18\3\0\0B\1\2\1K\0\1\0\0¿\19set_breakpoint\27Breakpoint condition: \ninput\afn\bvim≤\5\1\0\a\0#\0R6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\b\0003\5\t\0005\6\n\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\v\0003\5\f\0005\6\r\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\14\0003\5\15\0005\6\16\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\17\0003\5\18\0005\6\19\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\20\0003\5\21\0005\6\22\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\23\0003\5\24\0005\6\25\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\26\0003\5\27\0005\6\28\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\29\0003\5\30\0005\6\31\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4 \0003\5!\0005\6\"\0B\1\5\0012\0\0ÄK\0\1\0\1\0\1\tdesc(Toggle Debug conditional Breakpoint\0\15<leader>DB\1\0\1\tdesc\28Toggle Debug breakpoint\0\15<leader>Db\1\0\1\tdesc\rStep out\0\n<F12>\1\0\1\tdesc\14Step into\0\n<F11>\1\0\1\tdesc\14Step over\0\n<F10>\1\0\1\tdesc\28Run debugging to cursor\0\t<F7>\1\0\1\tdesc\14Open REPL\0\t<F6>\1\0\1\tdesc\23Continue debugging\0\t<F5>\1\0\1\tdesc\19Stop debugging\0\t<F2>\6n\bset\vkeymap\bvim\nsetup\26nvim-dap-virtual-text\bdap\frequire\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\nO\0\0\2\1\2\0\t-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\3Ä-\0\0\0009\0\1\0B\0\1\1K\0\1\0\0¿\19expand_or_jump\23expand_or_jumpableC\0\0\3\1\2\0\v-\0\0\0009\0\0\0)\2ˇˇB\0\2\2\15\0\0\0X\1\4Ä-\0\0\0009\0\1\0)\2ˇˇB\0\2\1K\0\1\0\0¿\tjump\rjumpableµ\2\1\0\a\0\21\0#6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\t\0006\4\4\0009\4\5\0049\4\6\4'\6\a\0B\4\2\2'\5\b\0&\4\5\4=\4\n\3B\1\2\0016\1\4\0009\1\v\0019\1\f\0015\3\r\0'\4\14\0003\5\15\0005\6\16\0B\1\5\0016\1\4\0009\1\v\0019\1\f\0015\3\17\0'\4\18\0003\5\19\0005\6\20\0B\1\5\0012\0\0ÄK\0\1\0\1\0\1\vsilent\2\0\n<C-k>\1\3\0\0\6i\6s\1\0\1\vsilent\2\0\n<C-j>\1\3\0\0\6i\6s\bset\vkeymap\npaths\1\0\1\npaths\0\14/snippets\vconfig\fstdpath\afn\bvim\14lazy_load\29luasnip.loaders.from_lua\fluasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22config.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n≤\1\0\0\6\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\5\0005\5\4\0=\5\6\4=\4\a\3B\1\2\1K\0\1\0\aui\nicons\1\0\1\nicons\0\1\0\3\24package_uninstalled\b‚úó\20package_pending\b‚ûú\22package_installed\b‚úì\1\0\2\aui\0\tPATH\vappend\nsetup\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
