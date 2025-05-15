return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', 
      build = 'make'
    },
    "nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
  },
  config = function()

    require("telescope").setup()

    pcall(require("telescope").load_extension, "fzf")
  end
}
