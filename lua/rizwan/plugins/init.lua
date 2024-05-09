local function from(name)
	return require("rizwan.plugins." .. name)
end

local lspconfig = from("lspconfig")

return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
		},
		config = from("nvim-tree"),
	},
	{
		'navarasu/onedark.nvim',
		config = from("one-dark"),
	},
  {
    'altermo/ultimate-autopair.nvim',
    event={'InsertEnter','CmdlineEnter'},
    branch='v0.6', --recommended as each new version will have breaking changes
    opts={},
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      "windwp/nvim-ts-autotag",
      "RRethy/nvim-treesitter-endwise",
      'nvim-treesitter/playground',
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
}
