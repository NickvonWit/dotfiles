return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      autostart = true,
      sources = {
        -- Formatters
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.cmake_format.with({
          filetypes = { "cmake" },
          extra_args = { "--line-width=120" }
        }),

        -- Linters
        null_ls.builtins.diagnostics.cmake_lint.with({
          filetypes = { "cmake" },
          extra_args = { "--line-width=120" }
        }),
        null_ls.builtins.diagnostics.actionlint,
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
}
