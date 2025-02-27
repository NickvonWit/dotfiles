return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			local harpoon = require("harpoon.mark")

			local function truncate_branch_name(branch)
				if not branch or branch == "" then
					return ""
				end

				-- Match the branch name to the specified format
				local user, team, ticket_number = string.match(branch, "^(%w+)/(%w+)%-(%d+)")

				-- If the branch name matches the format, display {user}/{team}-{ticket_number}, otherwise display the full branch name
				if ticket_number then
					return user .. "/" .. team .. "-" .. ticket_number
				else
					return branch
				end
			end

			local function harpoon_component()
				local total_marks = harpoon.get_length()

				if total_marks == 0 then
					return ""
				end

				local current_mark = "—"

				local mark_idx = harpoon.get_current_index()
				if mark_idx ~= nil then
					current_mark = tostring(mark_idx)
				end

				return string.format("󱡅 %s/%d", current_mark, total_marks)
			end

			-- Improved LSP component with comma-separated clients
			local function lsp_clients()
				local buf = vim.api.nvim_get_current_buf()
				local clients = vim.lsp.get_clients({ bufnr = buf })

				if #clients == 0 then
					return ""
				end

				local client_names = {}
				for _, client in ipairs(clients) do
					table.insert(client_names, client.name)
				end

				-- Format with a nice icon and comma-separated client names
				return " " .. table.concat(client_names, ", ")
			end

			-- Formatter component to show available formatters for current filetype
			local function formatters()
				local buf = vim.api.nvim_get_current_buf()
				local ft = vim.bo[buf].filetype
				
				-- Get formatters from conform.nvim if available
				local ok, conform = pcall(require, "conform")
				if not ok then
					return ""
				end
				
				local formatters_for_ft = conform.formatters_by_ft[ft]
				if not formatters_for_ft or #formatters_for_ft == 0 then
					return ""
				end
				
				-- Format with a nice icon and comma-separated formatter names
				return " " .. table.concat(formatters_for_ft, ", ")
			end

			require("lualine").setup({
				options = {
					theme = "catppuccin",
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "█", right = "█" },
				},
				sections = {
					lualine_b = {
						{ "branch", icon = "", fmt = truncate_branch_name },
						harpoon_component,
						"diff",
						"diagnostics",
					},
					lualine_c = {
						{ "filename", path = 1 },
					},
					lualine_x = {
						{
							lsp_clients,
							color = { fg = "#89b4fa" }, -- Use Catppuccin blue color for LSP names
							padding = { left = 1, right = 1 },
						},
						{
							-- Add a separator between LSP clients and formatters
							function()
								return "│"
							end,
							color = { fg = "#6c7086" }, -- Subtle color for the separator
							padding = { left = 0, right = 0 },
							cond = function()
								-- Only show separator if there are LSP clients
								local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
								return #clients > 0
							end,
						},
						{
							formatters,
							color = { fg = "#f9e2af" }, -- Use Catppuccin yellow color for formatters
							padding = { left = 1, right = 1 },
						},
						{
							-- Add a separator between formatters and filetype
							function()
								return "│"
							end,
							color = { fg = "#6c7086" }, -- Subtle color for the separator
							padding = { left = 0, right = 0 },
							cond = function()
								-- Only show separator if there are formatters
								local buf = vim.api.nvim_get_current_buf()
								local ft = vim.bo[buf].filetype
								local ok, conform = pcall(require, "conform")
								if not ok then return false end
								local formatters_for_ft = conform.formatters_by_ft[ft]
								return formatters_for_ft and #formatters_for_ft > 0
							end,
						},
						{
							"filetype",
							icon_only = false, -- Show both icon and name
							padding = { left = 1, right = 1 },
						},
					},
				},
			})
		end,
	},
}
