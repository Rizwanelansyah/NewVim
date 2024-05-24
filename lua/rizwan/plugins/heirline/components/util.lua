local M = {}

function M.surround(left, content, right, fg, bg, back)
  return {
    {
      provider = left,
      hl = { fg = bg, bg = back },
    },
    {
      hl = { fg = fg, bg = bg },
      {
        content
      }
    },
    {
      provider = right,
      hl = { fg = bg, bg = back },
    },
  }
end

return M
