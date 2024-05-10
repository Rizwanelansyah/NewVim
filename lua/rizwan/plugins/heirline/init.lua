---@diagnostic disable: undefined-global
local function from(mod)
  return require("rizwan.plugins.heirline." .. mod)
end

return function()
  local colors = require("onedark.colors")
  require("heirline").setup {
    statusline = from("statusline"),
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
