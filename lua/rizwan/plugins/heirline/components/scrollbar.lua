local colors = require("onedark.colors")
local utils = require("heirline.utils")
local condition = require("heirline.conditions")

return {
  provider = function()
    return "%7(%l/%3L%):%2c %P "
  end,
  condition = function()
    return condition.is_active() and (vim.bo.modifiable and not vim.bo.readonly)
  end,
  {
    {
      static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
      },
      provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
      end,
      hl = { fg = colors.green, bg = colors.grey },
      confition = function()
        return condition.is_active() and (vim.bo.modifiable and not vim.bo.readonly)
      end,
    }
  },
}
