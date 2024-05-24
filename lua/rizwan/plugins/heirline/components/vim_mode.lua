local cond = require('heirline.conditions')
local color = require("rizwan.plugins.heirline.colors")

return {
  init = function(self)
    self.mode = vim.fn.mode()
  end,
  static = {
    modes = {
      n = { s = "󰆾", n = "Normal", c = color.green },
      i = { s = "󰗧", n = "Insert", c = color.blue },
      v = { s = "󰫙", n = "Visual", c = color.purple },
      V = { s = "󰦨", n = "Vis-Line", c = color.purple },
      ["\22"] = { s = "󰩭", n = "Vis-Block", c = color.purple },
      c = { s = "󰷨", n = "Change", c = color.orange },
      s = { s = "󰷮", n = "Ch-Char", c = color.orange },
      S = { s = "󱍓", n = "Ch-Line", c = color.orange },
      ["\19"] = { s = "󰷨", n = "Change", c = color.orange },
      R = { s = "", n = "Replace", c = color.yellow },
      r = { s = "", n = "Rep-Char", c = color.yellow },
      ["!"] = { s = "", n = "Command", c = color.red },
      t = { s = "", n = "Terminal", c = color.red },
    }
  },
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      if cond.is_active() then
        vim.cmd.redrawstatus()
      end
    end),
  },
  {
    {
      init = function(self)
        local modes = self:nonlocal("modes")
        self.mode = modes[self:nonlocal("mode")]
      end,
      provider = function(self)
        return self.mode.s .. " "
      end,
      hl = function(self)
        return { fg = self.mode.c, bg = color.black }
      end
    },
    {
      init = function(self)
        local modes = self:nonlocal("modes")
        self.mode = modes[self:nonlocal("mode")]
      end,
      provider = function(self)
        return " " .. self.mode.n .. " "
      end,
      hl = function(self)
        return { fg = color.black, bg = self.mode.c, sp = color.black, bold = true }
      end
    },
    {
      init = function(self)
        local modes = self:nonlocal("modes")
        self.mode = modes[self:nonlocal("mode")]
      end,
      provider = "",
      hl = function(self)
        return { fg = self.mode.c, bg = color.black }
      end
    }
  }
}
