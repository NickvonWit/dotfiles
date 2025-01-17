return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function lsp_client_names()
      local clients = {}
      for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
        table.insert(clients, client.name)
      end
      return table.concat(clients, ", ")
    end

    require('lualine').setup({
      options = {
        theme = "catppuccin",
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
        globalstatus = true,
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {
          { 'mode', icons_enabled = true }
        },
        lualine_b = {
          { 'branch', icon = '' },
          { 
            'diff',
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' '
            }
          },
          'diagnostics'
        },
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 1, -- relative path
            symbols = {
              modified = '[+]',
              readonly = '[-]',
              unnamed = '[No Name]',
              newfile = '[New]',
            }
          }
        },
        lualine_x = {
          {
            lsp_client_names,
            icon = ' ',
            color = { fg = '#ffffff', gui = 'bold' }
          },
          'encoding',
          'fileformat',
          'filetype'
        },
        lualine_y = {
          'progress'
        },
        lualine_z = {
          'location'
        }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {
        'nvim-tree',
        'fugitive',
        'quickfix'
      }
    })
  end
}
