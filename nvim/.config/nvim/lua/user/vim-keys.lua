-- ==== Get the utils ====
local nnoremap = require("user.vim-keymap-utils").nnoremap
local vnoremap = require("user.vim-keymap-utils").vnoremap
local inoremap = require("user.vim-keymap-utils").inoremap
local tnoremap = require("user.vim-keymap-utils").tnoremap
local xnoremap = require("user.vim-keymap-utils").xnoremap

-- ==== TMUX keymaps ====
nnoremap("<C-j>", function()
  if vim.fn.exists(":NvimTmuxNavigateDown") ~= 0 then
    vim.cmd.NvimTmuxNavigateDown()
  else
    vim.cmd.wincmd("j")
  end
end)

nnoremap("<C-k>", function()
  if vim.fn.exists(":NvimTmuxNavigateUp") ~= 0 then
    vim.cmd.NvimTmuxNavigateUp()
  else
    vim.cmd.wincmd("k")
  end
end)

nnoremap("<C-l>", function()
  if vim.fn.exists(":NvimTmuxNavigateRight") ~= 0 then
    vim.cmd.NvimTmuxNavigateRight()
  else
    vim.cmd.wincmd("l")
  end
end)

nnoremap("<C-h>", function()
  if vim.fn.exists(":NvimTmuxNavigateLeft") ~= 0 then
    vim.cmd.NvimTmuxNavigateLeft()
  else
    vim.cmd.wincmd("h")
  end
end)


-- ==== General keymaps =====
nnoremap("<leader>h", ":nohlsearch<CR>",
  { desc = " Clear search highlight ", silent = true })

nnoremap("L", "$", { desc = "Jump to end of line" })
vnoremap("L", "$", { desc = "Jump to end of line" })
nnoremap("H", "^", { desc = "Jump to start of line" })
vnoremap("H", "^", { desc = "Jump to start of line" })
nnoremap("U", "<C-r>", { desc = "Redo" })

-- ==== Folding ====
nnoremap("zR", "<cmd>lua require('ufo').openAllFolds()<CR>", { desc = "Open all folds" })
nnoremap("zM", "<cmd>lua require('ufo').closeAllFolds()<CR>", { desc = "Close all folds" })
nnoremap("K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if winid ~= nil then
    vim.cmd("stopinsert")
  end
end, { desc = "Peek folded lines" })

-- ==== Quality of life shortcuts ====
nnoremap("<leader>'", "<C-^>", { desc = "Switch to last buffer" })
nnoremap("<leader>w", "<cmd>w<cr>", { desc = " Quick save", silent = false })
nnoremap("<leader>q", "<cmd>q<cr>", { desc = " Quick exit", silent = false })
nnoremap("<leader>e",
  function() require("oil").toggle_float() end, { desc = "Open file [E]xplorer" })
nnoremap("<leader>L",
  function() require("lazy").show() end, { desc = " Open [L]azy GUI " })

vnoremap("<", "<gv", { desc = "Better indent left" })
vnoremap(">", ">gv", { desc = "Better indent right" })

nnoremap("<leader>hs", "<cmd>split<cr>", { desc = " [H]orizontal [S]plit" })
nnoremap("<leader>vs", "<cmd>vsplit<cr>", { desc = " [V]ertical [S]plit" })


-- ==== Harpoon ====
local harpoon = require("harpoon")

nnoremap("<leader>ho", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[H]arpoon: [O]pen UI" })
nnoremap("<leader>ha", function() harpoon:list():add() end, { desc = "[H]arpoon: [A]dd current file" })
nnoremap("<leader>hr", function() harpoon:list():remove() end, { desc = "[H]arpoon: [R]emove current file" })
nnoremap("<leader>hc", function() harpoon:list():clear() end, { desc = "[H]arpoon: [C]lear all files" })

nnoremap("<leader>1", function()
  harpoon:list():select(1)
end, { desc = "Harpoon: jump 1" })

nnoremap("<leader>2", function()
  harpoon:list():select(2)
end, { desc = "Harpoon: jump 2" })

nnoremap("<leader>3", function()
  harpoon:list():select(3)
end, { desc = "Harpoon: jump 3" })

nnoremap("<leader>4", function()
  harpoon:list():select(4)
end, { desc = "Harpoon: jump 4" })

nnoremap("<leader>5", function()
  harpoon:list():select(5)
end, { desc = "Harpoon: jump 5" })

nnoremap("<leader>6", function()
  harpoon:list():select(6)
end, { desc = "Harpoon: jump 6" })

-- ==== Undo Tree ====
nnoremap("<leader>ut", ":UndotreeToggle<CR>", { desc = "Toggle [U]ndo[T]ree " })

-- ==== Telescope ====
local telescope = require("telescope.builtin")

nnoremap("<leader>fb", telescope.buffers, { desc = "Telescope: search buffers" })
nnoremap("<leader>fg", telescope.live_grep, { desc = "Telescope: live grep" })
nnoremap("<leader>fh", telescope.help_tags, { desc = "Telescope: help tags" })
nnoremap("<leader>ff", telescope.find_files, { desc = "Telescope: find files" })
nnoremap("<leader>fa", function()
  telescope.find_files({
    hidden = true,
    no_ignore = true,
    follow = true,
  })
end, { desc = "Telescope: find all files" })

-- ==== Snacks ====
local snacks = require("snacks")
-- Git
nnoremap("<leader>og", function() snacks.gitbrowse() end, { desc = "[O]pen [G]it" })

-- Notifier
nnoremap("<leader>nh", function() snacks.notifier.show_history() end, { desc = "Show [N]otifier [H]istory" })
nnoremap("<leader>z", function() snacks.toggle.dim():toggle() end, { desc = " Toggle [Z]en mode" })

-- ==== Git ====
local gitsigns = require("gitsigns")
nnoremap("<leader>gb", function() gitsigns.blame() end, { desc = "[G]it [B]lame" })
nnoremap("<leader>gd", function() gitsigns.diffthis() end, { desc = "[G]it [D]iff" })

-- ==== Mason/Lsp ====
nnoremap("<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })
nnoremap("<leader>so", "<cmd>Outline<cr>)", { desc = "[S]ymbols [O]utline" })
nnoremap("<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "[T]oggle [D]iagnostic" })

nnoremap("<leader>nd", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Goto next diagnostic" })
nnoremap("<leader>pd", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Goto previous diagnostic" })
nnoremap("<leader>ne", function()
  vim.diagnostic.jump({ count = 1, float = true, severity = { min = vim.diagnostic.severity.ERROR } })
end, { desc = "Goto next error" })
nnoremap("<leader>pe", function()
  vim.diagnostic.jump({ count = -1, float = true, severity = { min = vim.diagnostic.severity.ERROR } })
end, { desc = "Goto previous error" })
nnoremap("<leader>nw", function()
  vim.diagnostic.jump({ count = 1, float = true, severity = { min = vim.diagnostic.severity.WARN } })
end, { desc = "Goto next warning" })
nnoremap("<leader>pw", function()
  vim.diagnostic.jump({ count = -1, float = true, severity = { min = vim.diagnostic.severity.WARN } })
end, { desc = "Goto previous warning" })
-- Toggle between virtual_text and lsp_lines
nnoremap("<leader>ll", function()
  local config = vim.diagnostic.config()
  if config and config.virtual_lines then
    vim.diagnostic.config({
      virtual_text = true,
      virtual_lines = false,
    })
  else
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = true,
    })
  end
end, { desc = "Toggle LSP lines" })

-- ==== Copilot ====
nnoremap("<leader>ce", "<cmd>Copilot! attach<cr>", { desc = "[C]opilot [E]nable" })
nnoremap("<leader>cd", "<cmd>Copilot detach<cr>", { desc = "[C]opilot [D]isable" })
