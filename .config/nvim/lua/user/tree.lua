local tree_cb = require'nvim-tree.config'.nvim_tree_callback

-- nvim_tree_disable_netrw, nvim_tree_auto_close, nvim_tree_follow, nvim_tree_bindings, nvim_tree_hide_dotfiles, nvim_tree_ignore
require('nvim-tree').setup({
  view = {
    adaptive_size = false,
    mappings = {
      list = {
          { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
          { key = "h", action = "close_node" },
          { key = "v", action = "vsplit" },
          { key = "C", action = "cd" },
          { key = "v", action = "vsplit" },
          { key = "-", action = "split" },
      }
    }
  },
  filters = {
    dotfiles = false,
    custom = { '.git[/].*', '^.git$', 'node_modules', '.cache', '.idea', 'venv', '__pycache__' },
    exclude = { '[.]env', 'extensions.py' }
  },
  update_focused_file = {
    enable = true
  },
  disable_netrw = false, -- 1 by default, disables netrw
})

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})

vim.g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open

vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★",
    deleted = "",
    ignored = "◌"
  },
  folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  },
  lsp = {
    hint = "",
    info = "",
    warning = "",
    error = "",
  }
}



