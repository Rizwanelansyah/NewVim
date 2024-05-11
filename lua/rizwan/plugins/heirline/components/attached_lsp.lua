local colors = require("onedark.colors")
local condition = require("heirline.conditions")

return {
  provider = "LSP:",
  hl = function()
    return { fg = vim.g.heirline_mode_color, bg = colors.black }
  end,
  condition = function()
    local clients = vim.lsp.get_active_clients()
    return condition.is_active() and vim.o.modifiable and not vim.o.readonly and (clients ~= nil and #clients > 0)
  end,
  on_click = {
    name = "heirline_lsp_info",
    minwid = 0,
    callback = function()
      vim.cmd.LspInfo()
    end
  },
  {
    {
      provider = function()
        local str = " "
        for i, client in ipairs(vim.lsp.get_active_clients()) do
          str = str .. client.name .. '  '
        end
        return str
      end,
      hl = { bg = colors.black, fg = 'white' },
    },
    {
      provider = "  ",
      hl = { fg = "white", bg = colors.black },
      on_click = {
        name = "edit_lspconfig_file",
        minwid = 0,
        callback = function()
          vim.cmd [[ silent vsplit /home/rizwan/.config/nvim/lua/rizwan/plugins/lspconfig/init.lua ]]
        end,
      }
    }
  }
}
