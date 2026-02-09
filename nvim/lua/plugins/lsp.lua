return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    -- config здесь можно не писать, так как вы вызываете lsp_config.setup() в init.lua
  },
}
