return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "clangd", "pyright", "lua_ls" },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            border = "rounded",
          }
        }
      },
      "neovim/nvim-lspconfig",
      { "j-hui/fidget.nvim", opts = {} },
      {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline" },
        opts = {
          -- Your setup opts here
        },
      },
    },
  }
}
