return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			-- Configure telescope with better defaults
			telescope.setup({
				defaults = {
					path_display = { "truncate" },
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
						},
						width = 0.8,
						height = 0.8,
					},
					-- Add file ignore patterns
					file_ignore_patterns = {
						"node_modules",
						".git/",
						"dist/",
						"build/",
						"%.lock",
					},
				},
			})

			-- Keymaps
			local opts = { noremap = true, silent = true }

			-- File pickers
			vim.keymap.set("n", "<C-p>", builtin.find_files, opts)
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
			vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)

			-- Git pickers
			vim.keymap.set("n", "<leader>gc", builtin.git_commits, opts)
			vim.keymap.set("n", "<leader>gs", builtin.git_status, opts)

			-- LSP pickers
			vim.keymap.set("n", "<leader>fr", builtin.lsp_references, opts)
			vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, opts)
			vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, opts)

			-- Search
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, opts) -- Search word under cursor
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- Add some styling to the dropdown
							layout_config = {
								width = 0.6,
								height = 0.4,
							},
							border = true,
							previewer = false,
						}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	-- Optional but recommended extensions
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
}
