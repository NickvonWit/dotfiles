return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      animate = { enabled = true },
      bigfile = { enabled = true },
      git = { enabled = true },
      gitbrowse = { enabled = true },
      indent = { enabled = true },
      notifier = { enabled = true, timeout = 3000, },
      quickfile = { enabled = true },
      scroll = { enabled = true },
    },
  }
}
