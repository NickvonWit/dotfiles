return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      { "j-hui/fidget.nvim",    opts = {} },
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
