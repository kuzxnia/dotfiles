local status, lualine = pcall(require, "lualine")

--if (not status) then return end
lualine.setup {
  options = {
    icons_enabled = true,
    -- theme = 'vscode',
    theme = 'onedark',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = { 'packer', 'NvimTree' }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
        {'filename', path = 1},
    },
    lualine_x = {
      { 'diagnostics', sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'encoding',
      'filetype'
    },
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
  extensions = {'fugitive'},
}
