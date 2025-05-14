
-- ==== Get the utils ==== 
local nnoremap = require("user.keymap-utils").nnoremap
local vnoremap = require("user.keymap-utils").vnoremap
local inoremap = require("user.keymap-utils").inoremap
local tnoremap = require("user.keymap-utils").tnoremap
local xnoremap = require("user.keymap-utils").xnoremap

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
nnoremap("H", "^", { desc = "Jump to start of line" })
nnoremap("U", "<C-r>", { desc = "Redo" })

-- ==== Quality of life shortcuts ==== 
nnoremap("<leader>'", "<C-^>",      { desc = "Switch to last buffer" })  
nnoremap("<leader>w", "<cmd>w<cr>", { desc = " Quick save", silent = false })
nnoremap("<leader>q", "<cmd>q<cr>", { desc = " Quick exit", silent = false })
nnoremap("<leader>e", 
  function() require("oil").toggle_float() end, { desc = "Open file tree" })
nnoremap("<leader>L", 
  function() require("lazy").show() end, { desc = " Open lazy GUI "})

vnoremap("<", "<gv", { desc = "Better indent left" })
vnoremap(">", ">gv", { desc = "Better indent right" })

-- ==== Harpoon ====
local harpoon = require("harpoon")

nnoremap("<leader>ho", function() harpoon.ui:toggle_quick_menu(harpoon:list())  end, { desc = "Harpoon: Open UI" })
nnoremap("<leader>ha",function() harpoon:list():add() end, { desc = "Harpoon: Add current file" })
-- nnoremap("<leader>hr", function() harpoon:list():remove(), { desc = "Harpoon: Remove current file" })
-- nnoremap("<leader>hc", harpoon_mark.clear_all, { desc = "Harpoon: Remove all files" })

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
