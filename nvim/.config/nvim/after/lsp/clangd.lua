return {
  cmd = {
    'clangd',
    '--clang-tidy',
    '--background-index',
    '--offset-encoding=utf-8',
    '--fallback-style={IndentWidth: 2, TabWidth: 2, UseTab: Never}',
  },

  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  offsetEncoding = { 'utf-8', 'utf-16' },

  root_markers = {
    'CMakeLists.txt',
    'build/',
    'Makefile'
  },

  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
  },
}
