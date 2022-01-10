require "user.options"
require "user.autocommands"
require "user.keybindings"
require "user.plugins"
require "user.impatient"
require "user.alpha"
require "user.autopairs"
require "user.bufferline"
require "user.cmp"
require 'user.lsp'
require 'user.telescope'
require 'user.which-key'
require 'user.tree'
require 'user.lualine'
require 'user.dap'

require('gitsigns').setup()
require('shade').setup({ overlay_opacity = 50, opacity_step = 1 })
