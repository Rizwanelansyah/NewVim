local colors = require("onedark.colors")
local utils = require("heirline.utils")
local condition = require("heirline.conditions")

return {
  init = function(self)
    self.mode = vim.api.nvim_get_mode().mode:lower()
  end,
  static = {
    modes = {
      name = {
        n = " 󰆾  NORMAL ",
        v = " 󰩭  VISUAL ",
        ["\22"] = " 󰩭  VISUAL ",
        s = " 󰗧  SELECT ",
        i = "   INSERT ",
        r = "   REPLACE ",
        c = " 󰅽  COMMAND ",
        t = "   TERMINAL ",
      },
      hl = {
        n = colors.green,
        v = colors.purple,
        ["\22"] = colors.purple,
        s = colors.blue,
        i = colors.cyan,
        r = colors.orange,
        c = colors.red,
        t = colors.yellow,
      },
    },

    provider = function(self)
      local str = self.modes.name[self.mode or "n"] or ""
      vim.g.statusline_middle_space = vim.g.statusline_middle_space + utils.count_chars(str)
      return str
    end,

    hl = function(self)
      return { fg = "black", bg = self.modes.hl[self.mode], bold = true }
    end,

    condition = condition.is_active,
  }
}
