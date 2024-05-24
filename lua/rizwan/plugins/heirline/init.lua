---@diagnostic disable: undefined-global
local function from(mod)
  return require("rizwan.plugins.heirline." .. mod)
end

return function()
  require("heirline").setup {
    statusline = from("statusline"),
  }
end
