vim.g.statusline_middle_space = 0

return {
  {
    {
      require("rizwan.plugins.heirline.components.vimode"),
      require("rizwan.plugins.heirline.components.filename"),
    },
  },
  {
    provider = function()
      local text = (" "):rep(vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) - vim.g.statusline_middle_space)
      vim.g.statusline_middle_space = 0
      return text
    end
  },
  {
    require("rizwan.plugins.heirline.components.scrollbar"),
  },
}
