local function from(mod)
  return require("rizwan.plugins.heirline." .. mod)
end

function COUNT_MIDDLE_SPACE(str)
  vim.g.statusline_middle_space = vim.g.statusline_middle_space + require("heirline.utils").count_chars(str)
  return str
end

return function()
  require("heirline").setup {
    statusline = from("statusline"),
    winbar = {},
    tabline = {},
    statuscolumn = {},
  }

  local map = require("which-key")
  map.register({
    f = {
      l = { function() heirline_filename_on_click() end, "List File on This Current File Folder" }
    }
  }, {
    prefix = "<leader>",
    silent = true,
    noremap = true,
  })
end
