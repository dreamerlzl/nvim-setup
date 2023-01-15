lua << END
-- config for lualine

-- ref: https://github.com/nvim-lualine/lualine.nvim/issues/402
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'ayu_light',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        diagnostics_color = {
            error = "DiagnosticError",
            warn  = "DiagnosticWarn",
            info  = "DiagnosticInfo",
            hint  = "DiagnosticHint",
        }
      }
    },
    lualine_c = {
      {
        'filename',
        file_status = ture,
        path = 2,
        shorting_target = 20
      },
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
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
  extensions = {}
}

-- for lsp progress
require('fidget').setup{
  text = {
    spinner = "moon",
  },
}

END
