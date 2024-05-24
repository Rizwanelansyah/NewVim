local M = {}

M.before = function()
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"
  vim.o.number = true
  vim.o.tabstop = 2
  vim.o.shiftwidth = 2
  vim.o.expandtab = true
  vim.o.wrap = false
  vim.o.cursorline = false
  vim.o.scrolloff = 8
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.opt.termguicolors = true

  vim.cmd [[colorscheme habamax]]
end

M.after = function()
  vim.cmd [[ hi Float guibg=none ]]
  vim.cmd [[ hi NormalFloat guibg=none ]]
  vim.cmd [[ hi FloatBorder guibg=none guifg=teal ]]
  vim.cmd [[ hi MatchParen guibg=none guifg=orange ]]

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*" },
    callback = function()
      local clients = vim.lsp.get_clients()
      if clients then
        vim.lsp.buf.format {}
      end
    end
  })

  require("libs.vim.ui")
  local map = require("which-key")
  map.register({
    b = {
      name = "Buffer Actions",
      n = { "<CMD>bnext<CR>", "Next Buffer" },
      v = { "<CMD>bprevious<CR>", "Prev Buffer" },
      o = { "<CMD>BufferLineCloseOthers<CR>", "Close Other Buffers" },
      p = { "<CMD>BufferLinePick<CR>", "Pick Buffer" },
      c = { "<CMD>BufferLinePickClose<CR>", "Pick Close Buffer" },
      ["1"] = { "<CMD>bfirst<CR>", "First Buffer" },
      ["0"] = { "<CMD>blast<CR>", "Last Buffer" },
    }
  }, {
    prefix = "<leader>",
    noremap = true,
    silent = true,
    nowait = true,
  })
end

return M
