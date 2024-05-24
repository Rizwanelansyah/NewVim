return function()
  local mapping = require("simplyfile.mapping")
  require("simplyfile").setup {
    border = {
      -- up = { " ", " ", " ", "┐", "┘", "─", "└", "┌" },
      up = { " ", " ", " ", " ", "┘", "─", "└", " " },
      main = { "┬", "─", "┬", "│", "┴", "─", "┴", "│" },
      left = { "┌", "─", "─", " ", "─", "─", "└", "│" },
      right = { "─", "─", "┐", "│", "┘", "─", "─", " " },
    },
    keymaps = vim.tbl_extend("force", mapping.default, {
      d = function(dir)
        if not dir then return end
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.ui.select({ "No", "Yes" }, { prompt = "Move To Trash? " }, function(item)
          if item == "Yes" then
            vim.cmd("silent !trash " .. dir.absolute)
            ---@diagnostic disable-next-line: missing-fields
            mapping.refresh { absolute = "" }
            vim.api.nvim_win_set_cursor(0, { pos[1] > 1 and pos[1] - 1 or 1, pos[2] })
          end
        end)
      end,
      ["<CR>"] = function(dir)
        if not dir then return end
        if not dir.is_folder then
          vim.cmd("SimplyFileClose")
          vim.cmd("e " .. dir.absolute)
        end
      end,
    }),
    default_keymaps = true,
    preview = {
      show = function(dir)
        if vim.endswith(dir.name, ".png") then
          return false
        else
          return true
        end
      end,
    },
    clipboard = {
      notify = true,
    }
  }
  local map = require("which-key")
  map.register({
    f = {
      n = { "<CMD>SimplyFileOpen<CR>", "Open File Explorer" },
    }
  }, {
    prefix = "<leader>"
  })
end
