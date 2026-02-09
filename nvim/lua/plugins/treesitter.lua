return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("config.treesitter") -- просто вызываем ваш старый файл конфигурации
  end,
}
