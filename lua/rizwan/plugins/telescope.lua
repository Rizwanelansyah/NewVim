return function()
  require("notify").setup {
    background_colour = "#000000",
    top_down = true,
    fps = 10,
  }
  vim.notify = require("notify")
  local builtin = require("telescope.builtin")
  require("telescope").load_extension("notify")
  local map = require("which-key")
  map.register({
    f = {
      f = { builtin.find_files, "Find Files" },
      g = { builtin.live_grep, "Live Grep" },
      h = { builtin.help_tags, "Find Help Tags" },
      b = { builtin.builtin, "Builtin Telescope" },
      m = { require('telescope').extensions.notify.notify, "Find Notify Messages" },
    }
  }, {
    noremap = true,
    silent = true,
    prefix = "<leader>"
  })
end
