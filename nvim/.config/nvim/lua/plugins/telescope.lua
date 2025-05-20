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

    require("telescope").setup {
      pickers = {
        find_files = {
          theme = "ivy"
        }
      },
    }
    pcall(require("telescope").load_extension, "fzf")
  end
}
