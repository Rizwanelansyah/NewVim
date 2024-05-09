---@param client lsp.Client
---@param bufnr integer
return function(client, bufnr)
  local map = require("which-key")
  map.register(
    {
      l = {
        name = "Lsp",
        f = { vim.lsp.buf.format, "Format File" },
        k = { vim.lsp.buf.hover, "Hover" },
        K = { vim.lsp.buf.signature_help, "Signature Help" },
        a = { vim.lsp.buf.code_action, "Code Action" },
        d = { vim.lsp.buf.definition, "Go To Definition" },
        D = { vim.lsp.buf.declaration, "Go To Declaration" },
        c = { vim.lsp.buf.incoming_calls, "Incomming Calls" },
        C = { vim.lsp.buf.outgoing_calls, "Outgoing Calls" },
        h = { vim.lsp.buf.document_highlight, "Document Highlight" },
        s = { vim.lsp.buf.document_symbol, "Document Symbols" },
        r = { vim.lsp.buf.rename, "Rename Symbol" },
        w = {
          name = "Workspaces",
          a = { vim.lsp.buf.add_workspace_folder, "Add" },
          l = { vim.lsp.buf.list_workspace_folders, "Show List" },
          r = { vim.lsp.buf.remove_workspace_folder, "Remove" },
          s = { vim.lsp.buf.workspace_symbol, "Symbols" },
        },
      }
    },
    {
      prefix = "<leader>",
      noremap = true,
      silent = true,
      bufnr = bufnr,
    }
  )

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
    hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  ]]
    vim.api.nvim_create_augroup('lsp_document_highlight', {
      clear = false
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = 'lsp_document_highlight',
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end
