return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-ui-select.nvim",
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
    require("telescope").load_extension("ui-select")
  end
}
