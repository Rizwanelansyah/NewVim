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

  vim.cmd [[colorscheme habamax]]
end

M.after = function()
  vim.cmd [[colorscheme onedark]]

  vim.cmd [[ hi Float guibg=none ]]
  vim.cmd [[ hi NormalFloat guibg=none ]]
  vim.cmd [[ hi FloatBorder guibg=none guifg=teal ]]
  vim.cmd [[ hi MatchParen guibg=none guifg=orange ]]

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*" },
    callback = function()
      local clients = vim.lsp.get_active_clients()
      if clients then
        vim.lsp.buf.format {}
      end
    end
  })

  require("libs.vim.ui")
end

return M
