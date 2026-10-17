return {
  "xiyaowong/transparent.nvim",
  lazy = false, -- Плагин должен работать сразу при запуске
  config = function()
    require("transparent").setup({
      -- Группы, которые станут прозрачными
      extra_groups = {
        "NormalFloat", -- Всплывающие окна (например, подсказки LSP)
        "NeoTreeNormal", -- Фон проводника Neo-tree
        "NeoTreeNormalNC",
      },
    })
  end,
}
