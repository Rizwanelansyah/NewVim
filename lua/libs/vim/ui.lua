local ui = require("libs.ui")
local Menu = require("nui.menu")

vim.ui.input = function(opts, on_confirm)
  ui.prompt(opts.prompt or "", opts.default or "", on_confirm,
    function(opts)
      opts.size.width = 50
      opts.relative = 'cursor'
      opts.position = {
        row = 2,
        col = 0,
      }
    end
  )
end

vim.ui.select = function(items, opts, on_choice)
  local len = 50
  for i, item in ipairs(items) do
    local text = item
    if opts.format_item then
      text = opts.format_item(text)
    end
    if #text > len then
      len = #text
    end
    items[i] = Menu.item(text, { value = item, idx = i })
  end

  ui.select(opts.prompt or "", items, function(node)
    on_choice(node.value, node.idx)
  end, function(opts)
    opts.relative = 'cursor'
    opts.size.width = len
    opts.position = {
      row = 2,
      col = 0,
    }
  end)
end
