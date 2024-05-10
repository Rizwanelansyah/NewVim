return function()
  local builtin = require("telescope.builtin")
  local map = require("which-key")
  map.register({
    f = {
      f = { builtin.find_files, "Find Files" },
      g = { builtin.live_grep, "Live Grep" },
      h = { builtin.help_tags, "Find Help Tags" },
      b = { builtin.builtin, "Builtin Telescope" },
    }
  }, {
    noremap = true,
    silent = true,
    prefix = "<leader>"
  })
end
