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
        null_ls.builtins.formatting.cmake_format,

        -- Linters
        null_ls.builtins.diagnostics.cmake_lint,
        null_ls.builtins.diagnostics.actionlint,
      },
    })
  end,
}

