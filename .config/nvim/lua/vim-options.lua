-- Basic settings
vim.g.mapleader = " "
vim.g.background = "light"

-- Indentation
vim.opt.expandtab = true      -- Convert tabs to spaces
vim.opt.tabstop = 2          -- Insert 2 spaces for a tab
vim.opt.softtabstop = 2      -- Number of spaces tabs count for while editing
vim.opt.shiftwidth = 2       -- Number of spaces for autoindent
vim.opt.smartindent = true   -- Make indenting smart
vim.opt.autoindent = true    -- Copy indent from current line when starting a new line

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4      -- Set number column width
vim.opt.signcolumn = "yes"   -- Always show the signcolumn

-- File handling
vim.opt.swapfile = false
vim.opt.backup = false       -- Don't create backup files
vim.opt.undofile = true      -- Enable persistent undo
vim.opt.writebackup = false  -- Don't write backup files

-- Search
vim.opt.hlsearch = true      -- Highlight search results
vim.opt.ignorecase = true    -- Ignore case when searching
vim.opt.smartcase = true     -- Override ignorecase if search pattern has uppercase
vim.opt.incsearch = true     -- Show search matches as you type

-- UI config
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.showmode = false     -- Don't show mode in command line
vim.opt.scrolloff = 8        -- Minimum number of lines to keep above and below cursor
vim.opt.sidescrolloff = 8    -- Minimum number of columns to keep left and right of cursor
vim.opt.wrap = false         -- Display long lines as just one line
vim.opt.cursorline = true    -- Highlight the current line

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- General keymaps
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { silent = true })

-- Quality of life improvements
vim.keymap.set('n', '<leader>w', ':w<CR>', { silent = true })        -- Quick save
vim.keymap.set('v', '<', '<gv', { silent = true })                   -- Better indenting
vim.keymap.set('v', '>', '>gv', { silent = true })                   -- Better indenting
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })     -- Move text up and down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })     -- Move text up and down

-- Split window management
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { silent = true }) -- Split vertically
vim.keymap.set('n', '<leader>sh', ':split<CR>', { silent = true })  -- Split horizontally

-- Buffer navigation
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { silent = true })     -- Next buffer
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', {  silent = true }) -- Previous buffer
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { silent = true })   -- Delete buffer

-- Clipboard
vim.opt.clipboard = 'unnamedplus'  -- Use system clipboard
