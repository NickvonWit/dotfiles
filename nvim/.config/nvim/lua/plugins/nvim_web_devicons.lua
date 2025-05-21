return {
  {
    "nvim-tree/nvim-web-devicons",
    opts = {},
    config = function()
      require("nvim-web-devicons").setup({
        override = {
          cpp = {
            icon = "", -- default C++ icon
            color = "#005f87",
            name = "Cpp",
          },
          cmake = {
            icon = "",
            color = "#6d8086",
            name = "CMake",
          },
          rs = {
            icon = "",
            color = "#dea584",
            name = "Rust",
          },
        },
      })
    end,
  },
}
