local function from(name)
  return require("rizwan.plugins." .. name)
end

local lspconfig = from("lspconfig")

return {
  {
    'navarasu/onedark.nvim',
    config = from("one-dark"),
  },
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recommended as each new version will have breaking changes
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      "windwp/nvim-ts-autotag",
      "RRethy/nvim-treesitter-endwise",
      'nvim-treesitter/playground',
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = from("treesitter"),
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = from("which-key"),
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = lspconfig.dep,
    config = lspconfig.config,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = from("rainbow-delimiter")
  },

  {
    "rebelot/heirline.nvim",
    config = from("heirline"),
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = from("telescope"),
  },

  {
    "chrisgrieser/nvim-scissors",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require("scissors").setup {
        snippetDir = "/home/rizwan/Tools/snippets",
      }
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "/home/rizwan/Tools/snippets" } }
    end
  },

  {
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = from("symbol-usage"),
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- {
  --   "yamatsum/nvim-cursorline",
  --   dependencies = {
  --     "xiyaowong/nvim-cursorword",
  --   },
  --   opts = {
  --     cursorline = {
  --       enable = true,
  --       timeout = 1000,
  --       number = false,
  --     },
  --     cursorword = {
  --       enable = true,
  --       min_length = 3,
  --       hl = vim.api.nvim_get_hl(0, { name = "CursorLine" }),
  --     },
  --   },
  -- },

  {
    "VidocqH/auto-indent.nvim",
    opts = {},
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  {
    "Rizwanelansyah/simplyfile.nvim",
    tag = "v0.3",
    -- dir = "/home/rizwan/Projects/nvim/simplyfile.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = from("simplyfile"),
  },
}
