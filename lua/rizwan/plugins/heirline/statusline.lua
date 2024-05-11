vim.g.statusline_middle_space = 1
local colors = require("onedark.colors")
local condition = require("heirline.conditions")
vim.g.heirline_mode_color = colors.green

return {
  require("rizwan.plugins.heirline.components.vimode"),
  {
    provider = "",
    hl = function()
      return { fg = vim.g.heirline_mode_color, bg = colors.black }
    end,
    condition = function()
      return condition.is_active() and (vim.bo.modifiable and not vim.bo.readonly)
    end,
  },
  require("rizwan.plugins.heirline.components.filename"),
  {
    provider = "",
    hl = function()
      return { fg = colors.black, bg = vim.g.heirline_mode_color }
    end
  },
  {
    provider = "%=",
    hl = function()
      return { bg = vim.g.heirline_mode_color }
    end
  },
  {
    provider = " ",
    hl = function()
      return { bg = vim.g.heirline_mode_color }
    end
  },
  {
    provider = "",
    hl = function()
      return { fg = colors.black, bg = vim.g.heirline_mode_color }
    end
  },
  {
    provider = function()
      return os.date("%H:%M:%S")
    end,
    hl = {
      bg = colors.black,
      fg = colors.green
    }
  },
  {
    provider = "",
    hl = function()
      return { fg = colors.black, bg = vim.g.heirline_mode_color }
    end
  },
  {
    provider = "%=",
    hl = function()
      return { bg = vim.g.heirline_mode_color }
    end
  },
  {
    provider = " ",
    hl = function()
      return { bg = vim.g.heirline_mode_color }
    end
  },
  require("rizwan.plugins.heirline.components.diagnostic"),
  require("rizwan.plugins.heirline.components.attached_lsp")
}
