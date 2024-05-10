local conditions = require("heirline.conditions")
local colors = require("onedark.colors")

return {

  condition = conditions.has_diagnostics,

  static = {
    error_icon = " ",
    warn_icon = " ",
    info_icon = " ",
    hint_icon = " ",
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = "",
    hl = function()
      return { fg = colors.black, bg = vim.g.heirline_mode_color }
    end,
  },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = colors.red, bg = colors.black },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = colors.yellow, bg = colors.black },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = colors.blue, bg = colors.black },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = colors.purple, bg = colors.black },
  },
  {
    provider = "",
    hl = function()
      return { fg = colors.black, bg = vim.g.heirline_mode_color }
    end,
  },
}
