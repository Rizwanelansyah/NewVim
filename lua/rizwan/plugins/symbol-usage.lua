return function()
  local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end
  local colors = require("onedark.colors")

  vim.api.nvim_set_hl(0, 'SymbolUsageRef', { bg = h('Type').fg, fg = colors.black, bold = true })
  vim.api.nvim_set_hl(0, 'SymbolUsageRefRound', { fg = h('Type').fg })

  vim.api.nvim_set_hl(0, 'SymbolUsageDef', { bg = h('Function').fg, fg = colors.black, bold = true })
  vim.api.nvim_set_hl(0, 'SymbolUsageDefRound', { fg = h('Function').fg })

  vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { bg = h('@parameter').fg, fg = colors.black, bold = true })
  vim.api.nvim_set_hl(0, 'SymbolUsageImplRound', { fg = h('@parameter').fg })

  local function text_format(symbol)
    local res = {}

    -- Indicator that shows if there are any other symbols in the same line
    local stacked_functions_content = symbol.stacked_count > 0
        and ("+%s"):format(symbol.stacked_count)
        or ''

    if symbol.references then
      table.insert(res, { '', 'SymbolUsageRefRound' })
      table.insert(res, { '󰌹 ' .. tostring(symbol.references), 'SymbolUsageRef' })
      table.insert(res, { '', 'SymbolUsageRefRound' })
    end

    if symbol.definition then
      if #res > 0 then
        table.insert(res, { ' ', 'NonText' })
      end
      table.insert(res, { '', 'SymbolUsageDefRound' })
      table.insert(res, { '󰳽 ' .. tostring(symbol.definition), 'SymbolUsageDef' })
      table.insert(res, { '', 'SymbolUsageDefRound' })
    end

    if symbol.implementation then
      if #res > 0 then
        table.insert(res, { ' ', 'NonText' })
      end
      table.insert(res, { '', 'SymbolUsageImplRound' })
      table.insert(res, { '󰡱 ' .. tostring(symbol.implementation), 'SymbolUsageImpl' })
      table.insert(res, { '', 'SymbolUsageImplRound' })
    end

    if stacked_functions_content ~= '' then
      if #res > 0 then
        table.insert(res, { ' ', 'NonText' })
      end
      table.insert(res, { '', 'SymbolUsageImplRound' })
      table.insert(res, { ' ' .. tostring(stacked_functions_content), 'SymbolUsageImpl' })
      table.insert(res, { '', 'SymbolUsageImplRound' })
    end

    return res
  end

  require('symbol-usage').setup({
    text_format = text_format,
  })
end
