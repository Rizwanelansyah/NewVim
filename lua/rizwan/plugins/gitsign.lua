local function on_attach(bufnr)
  local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  -- Navigation
  map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true, desc = "Next Hunk" })
  map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true, desc = "Prev Hunk" })

  -- Actions
  map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = "Stage Hunk" })
  map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = "Stage Hunk" })
  map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = "Reset Hunk" })
  map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = "Reset Hunk" })
  map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>', { desc = "Stage Buffer" })
  map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', { desc = "Undo Stage Hunk" })
  map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>', { desc = "Reset Buffer" })
  map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', { desc = "Preview Hunk" })
  map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', { desc = "Full Blame Line" })
  map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>', { desc = "GitSigns: Current Line Blame" })
  map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>', { desc = "Diff This" })
  map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>', { desc = "Diff This ~" })
  map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>', { desc = "GitSigns: Delete" })

  -- Text object
  -- map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  -- map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')

  require("which-key").register({
    h = { name = "GitSigns" },
    t = { name = "Toggle" },
  }, {
    prefix = "<leader>"
  })
  require("which-key").register({
    h = { name = "GitSigns" },
  }, {
    mode = "v",
    prefix = "<leader>"
  })
end

return function()
  require("gitsigns").setup {
    on_attach = on_attach,
    numhl = true,
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 200,
    },
  }
end
