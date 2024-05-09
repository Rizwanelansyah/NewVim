local M = {}

M.before = function()
	vim.g.mapleader = " "
	vim.g.maplocalleader = "\\"
	vim.o.number = true
	vim.o.tabstop = 2
	vim.o.shiftwidth = 2
	vim.o.expandtab = true
	vim.o.wrap = false
	vim.o.cursorline = true

  vim.cmd[[colorscheme habamax]]
end

M.after = function()
  vim.cmd[[colorscheme onedark]]

  vim.cmd[[ hi Float guibg=none ]]
  vim.cmd[[ hi NormalFloat guibg=none ]]
  vim.cmd[[ hi FloatBorder guibg=none guifg=teal ]]

  vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = {"*"},
    callback = function(_)
      local clients = vim.lsp.get_active_clients()
      if clients then
        vim.lsp.buf.format {}
      end
    end
  })
end

return M
