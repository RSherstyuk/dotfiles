require('nvim-treesitter.configs').setup({
  ensure_installed = { "cmake", "c", "cpp", "lua", "java", "python" },
  sync_install = false,

  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
  },

})
