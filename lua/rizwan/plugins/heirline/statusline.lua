local util = require("rizwan.plugins.heirline.components.util")
local color = require("rizwan.plugins.heirline.colors")

return {
  util.surround('', require("rizwan.plugins.heirline.components.vim_mode"), '', "black", "black", "none"),
  { provider = " ",  hl = { bg = "none" } },
  util.surround('', require("rizwan.plugins.heirline.components.file"), '', "black", "black", "none"),
  { provider = "%=", hl = { bg = "none" } },
  require("rizwan.plugins.heirline.components.navic"),
  { provider = "%=", hl = { bg = "none" } },
  require("rizwan.plugins.heirline.components.diagnostic"),
  { provider = " ",  hl = { bg = "none" } },
  require("rizwan.plugins.heirline.components.lsp"),
  {
    provider = " ",
    hl = { fg = color.black, bg = "none" }
  },
  {
    static = {
      sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
    },
    provider = function(self)
      local curr_line = vim.api.nvim_win_get_cursor(0)[1]
      local lines = vim.api.nvim_buf_line_count(0)
      local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
      return self.sbar[i] .. " %P "
    end,
    hl = { fg = color.blue, bg = color.black },
  },
}
