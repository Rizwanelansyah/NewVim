local conditions = require("heirline.conditions")
local color = require("rizwan.plugins.heirline.colors")

return {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = color.orange },


  {
    provider = "",
    hl = { fg = color.black, bg = "none" }
  },
  {
    provider = function(self)
      return " " .. self.status_dict.head .. " "
    end,
    hl = { bold = true, fg = color.orange, bg = color.black }
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("+" .. count)
    end,
    hl = { fg = color.black, bg = color.orange },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("-" .. count)
    end,
    hl = { fg = color.black, bg = color.orange },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("~" .. count)
    end,
    hl = { fg = color.black, bg = color.orange },
  },
  {
    provider = "",
    hl = { fg = color.black, bg = "none" }
  },
}
