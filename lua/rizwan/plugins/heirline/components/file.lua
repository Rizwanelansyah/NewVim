local color = require("rizwan.plugins.heirline.colors")

return {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(self.filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(self.filename, extension, { default = true })
  end,
  {
    provider = function(self)
      return self:nonlocal("icon") and (self:nonlocal("icon") .. " ")
    end,
    hl = function(self)
      return { fg = self:nonlocal("icon_color"), bg = color.black }
    end
  },
  {
    provider = function(self)
      return " " .. vim.fs.basename(self:nonlocal("filename")) .. " "
    end,
    hl = function(self)
      return { fg = color.black, bg = self:nonlocal("icon_color") }
    end
  },
  {
    provider = "",
    hl = function(self)
      return { fg = self:nonlocal("icon_color"), bg = color.black }
    end
  },
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = "  ",
    hl = { fg = color.green },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = "  ",
    hl = { fg = color.red },
  },
}
