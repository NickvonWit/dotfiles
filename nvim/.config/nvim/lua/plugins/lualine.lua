return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      local function harpoon_component()
        local harpoon = require("harpoon")

        -- Get the list object and its items
        local list = harpoon:list()
        local harpoon_items = list.items

        -- Get total number of marks
        local total_marks = #harpoon_items

        if total_marks == 0 then
          return ""
        end

        local current_mark = "—"

        -- Get current file path using the same method as harpoon-lualine
        local current_file_path = vim.api.nvim_buf_get_name(0)
        local root_dir = list.config:get_root_dir()

        -- Find the current file in the harpoon items
        for i = 1, total_marks do
          local harpoon_item = harpoon_items[i]
          if harpoon_item then
            local harpoon_path = harpoon_item.value

            local full_path = harpoon_path
            -- Handle relative paths if needed
            if harpoon_path:sub(1, 1) ~= "/" and harpoon_path:sub(2, 2) ~= ":" then
              full_path = root_dir .. "/" .. harpoon_path
            end

            if full_path == current_file_path then
              current_mark = tostring(i)
              break
            end
          end
        end

        return string.format("󱡅 %s/%d", current_mark, total_marks)
      end

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

        return " " .. table.concat(client_names, ", ")
      end

      require("lualine").setup({
        options = {
          theme = "catppuccin",
        },
        sections = {
          lualine_b = {
            "branch",
            "diff",
            "diagnostics",
            harpoon_component,
          },

          lualine_x = {
            lsp_clients,
            'encoding',
            'filetype',
          },
        }
      })
    end
  },
}
