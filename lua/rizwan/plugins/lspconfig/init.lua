local M = {}

M.dep = {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },
  {
    "folke/neodev.nvim",
    opts = {},
  },
}

M.config = function()
  local lspconfig = require("lspconfig")
  local base = {
    capabilities = require("rizwan.plugins.lspconfig.capabilities"),
    on_attach = require("rizwan.plugins.lspconfig.on_attach"),
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' }),
    },
  }
  require("rizwan.plugins.lspconfig.servers")(lspconfig, base)

  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = false,
    update_in_insert = false,
    severity_sort = false,
  })

  for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    vim.fn.sign_define("DiagnosticSign" .. diag, {
      text = "",
      texthl = "DiagnosticSign" .. diag,
      linehl = "",
      numhl = "DiagnosticSign" .. diag,
    })
  end
  require('lspconfig.ui.windows').default_options.border = 'single'
end

return M
