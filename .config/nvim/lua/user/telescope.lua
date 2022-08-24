local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    prompt_prefix = '🔍 ',
    layout_strategy = 'vertical',
    layout_config = {
      width = 0.9,
      height = 0.95
    },
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--line-number',
      '--column',
      '--smart-case',
      '-u' -- thats the new thing
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
      n = {
        ["<esc>"] = actions.close,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
  },
  pickers = {
    find_files = {
      find_command = {'rg', '--ignore', '--hidden', '--files', '--no-ignore-vcs'},
    },
    buffers = {
      sort_lastused = true,
      ignore_current_buffer = true
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('dap')
require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("flutter")


_G.telescope_find_files_in_path = function(path)
 local _path = path or vim.fn.input("Dir: ", "", "dir")
 require("telescope.builtin").find_files({search_dirs = {_path}})
end
_G.telescope_live_grep_in_path = function(path)
 local _path = path or vim.fn.input("Dir: ", "", "dir")
 require("telescope.builtin").live_grep({search_dirs = {_path}})
end

_G.telescope_live_grep_git = function()
 require("telescope.builtin").live_grep({vimgrep_arguments = { 'rg', '--no-heading', '--column', '--smart-case', '--ignore-vcs'}})
end

_G.telescope_files_or_git_files = function()
 local utils = require('telescope.utils')
 local builtin = require('telescope.builtin')
 local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
 if ret == 0 then
   builtin.git_files()
 else
   builtin.find_files()
 end
end
