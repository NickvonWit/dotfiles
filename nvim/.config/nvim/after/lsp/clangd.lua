return {
  cmd = {
    'clangd',
    '--clang-tidy',
    '--background-index',
    '--offset-encoding=utf-8',
  },

  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  offsetEncoding = { 'utf-8', 'utf-16' },

  root_markers = {
    'CMakeLists.txt',
    'build/'
  },

  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
  },
}
