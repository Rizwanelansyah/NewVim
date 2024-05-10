local colors = require("onedark.colors")
local utils = require("heirline.utils")

return {
  provider = function()
    return COUNT_MIDDLE_SPACE("%7(%l/%3L%):%2c %P ")
  end,
  condition = require("heirline.conditions").is_active,
  {
    {
      static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
      },
      provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return COUNT_MIDDLE_SPACE(string.rep(self.sbar[i], 2))
      end,
      hl = { fg = colors.green, bg = colors.grey },
    }
  },
}
