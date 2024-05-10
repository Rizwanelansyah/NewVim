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
        row = vim.api.nvim_win_get_cursor(0)[1] + 2,
      },
      focusable = true,
    },
    {
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
---@param override? fun(opts: nui_popup_options)
function M.select(text, values, handler, override)
  local Menu = require("nui.menu")
  local lines = {}
  for i, line in ipairs(values) do
    if type(line) == "table" then
      lines[i] = line
    else
      lines[i] = Menu.item(line)
    end
  end

  local opts = {
    size = {
      width = 50,
      height = #lines + 2,
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
      row = vim.api.nvim_win_get_cursor(0)[1] + 2,
    },
    focusable = true,
  }

  if override then
    override(opts)
  end

  local menu = Menu(opts,
    {
      lines = lines,
      on_submit = handler,
      keymap = {
        focus_next = { "j", "<Down>", "<Tab>" },
        focus_prev = { "k", "<Up>", "<S-Tab>" },
        close = { "<Esc>", "<C-c>" },
        submit = { "<CR>", "<Space>" },
      },
    })

  menu:map("n", "<ESC>", function()
    menu:unmount()
  end)

  menu:mount()
end

return M
