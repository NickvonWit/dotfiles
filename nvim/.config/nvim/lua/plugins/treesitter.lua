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

        ignore_install = {},

        modules = {},

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          -- Enable highlighting
          enable = true,
          -- Disable highlighting for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
        },
      })
    end,
  },
}
