return function()
	-- disable netrw at the very start of your init.lua
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	-- optionally enable 24-bit colour
	vim.opt.termguicolors = true

	-- empty setup using defaults
	require("nvim-tree").setup {
    renderer = {
      add_trailing = true,
      full_name = true,
      root_folder_label = function(path)
        local home = os.getenv("HOME")
        return path:gsub(home .. "/.config/", "=>"):gsub(home .. "/?", "~>"):gsub("/", "->")
      end,
      highlight_git = "all",
      highlight_diagnostics = "all",
      highlight_opened_files = "all",
      highlight_modified = "all",
      indent_markers = {
        enable = true,
      },
    },
    diagnostics = {
      enable = true,
    },
    modified = {
      enable = true,
    },
    trash = {
      cmd = "trash",
    },
    on_attach = require("rizwan.plugins.nvim-tree.on_attach"),
  }

	vim.keymap.set("n", "<leader>fe", "<CMD>NvimTreeToggle<CR>")
  local map = require("which-key")
  map.register(
    {
      f = {
        name = "Files & Find",
        e = { "<CMD>NvimTreeToggle<CR>", "Toggle Nvim Tree" },
      },
    },
    {
      prefix = "<leader>",
      silent = true,
      noremap = true,
      nowait = false,
    }
  )
end
