local cond = require('heirline.conditions')
local color = require("rizwan.plugins.heirline.colors")

return {
  condition = cond.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  {
    { provider = " ", hl = { bg = "none", fg = color.yellow } },
    {
      provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_clients { bufnr = 0 }) do
          table.insert(names, server.name)
        end
        return table.concat(names, ",")
      end,
      hl = { fg = color.red, bold = true, bg = "none" },
    },
  }
}
