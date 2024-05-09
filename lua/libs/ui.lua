local M = {}

---@param text string
---@param default string
---@param handler fun(value: string): nil
function M.prompt(text, default, handler)
  local Input = require("nui.input")
  local input = Input(
    {
      size = {
        width = 50,
        height = 1,
      },
      enter = true,
      border = {
        style = 'single',
        text = {
          top = "[ " .. text .. " ]",
          top_align = 'left',
        },
      },
      zindex = 100,
      relative = 'editor',
      position = {
        col = 0,
        row = vim.api.nvim_win_get_cursor(0)[1] + 1,
      },
      focusable = true,
    },
    {
      prompt = ": ",
      default_value = default,
      on_submit = handler,
    }
  )

  input:map("n", "<ESC>", function()
    input:unmount()
  end)

  input:mount()
end

---@param text string
---@param values string[]
---@param handler fun(node: NuiTree.Node)
function M.select(text, values, handler)
  local Menu = require("nui.menu")
  local lines = {}
  for i, line in ipairs(values) do
    lines[i] = Menu.item(line)
  end
  local menu = Menu(
    {
      size = {
        width = 50,
        height = #lines,
      },
      enter = true,
      border = {
        style = 'single',
        text = {
          top = "[ " .. text .. " ]",
          top_align = 'left',
        },
      },
      zindex = 100,
      relative = 'editor',
      position = {
        col = 0,
        row = vim.api.nvim_win_get_cursor(0)[1] + 1,
      },
      focusable = true,
    },
    {
      lines = lines,
      on_submit = handler,
      keymap = {
        focus_next = { "j", "<Down>", "<Tab>" },
        focus_prev = { "k", "<Up>", "<S-Tab>" },
        close = { "<Esc>", "<C-c>" },
        submit = { "<CR>", "<Space>" },
      },
    }
  )

  menu:map("n", "<ESC>", function()
    menu:unmount()
  end)

  menu:mount()
end

return M
