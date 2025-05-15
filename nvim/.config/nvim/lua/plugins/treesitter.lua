return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          -- Core languages for C/C++/HPC development
          "c",
          "cpp",
          "cuda",
          "cmake",
          "make",
          "fortran",
          "meson",
          "julia",

          -- Supporting languages
          "lua",
          "vim",
          "bash",
          "python",
          "markdown",
          "yaml",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          -- Enable highlighting
          enable = true,
        },

        indent = {
          enable = true,
        },
      })
    end,
  },
}
