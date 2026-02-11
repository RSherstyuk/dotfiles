require("ufo").setup({
  provider_selector = function()
    return { "treesitter", "indent" }
  end,
  open_fold_hl_timeout = 150,

  fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local foldedLines = endLnum - lnum
    local totalLines = vim.api.nvim_buf_line_count(0)
    local percent = math.floor((foldedLines / totalLines) * 100)

    local suffix = (" 󰁂 %d lines  %d%% "):format(foldedLines, percent)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0

    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)

      if curWidth + chunkWidth < targetWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        table.insert(newVirtText, { chunkText, chunk[2] })
        break
      end
      curWidth = curWidth + chunkWidth
    end

    -- красивый разделитель
    table.insert(newVirtText, { " … ", "Comment" })
    table.insert(newVirtText, { suffix, "Folded" })

    return newVirtText
  end,
})
