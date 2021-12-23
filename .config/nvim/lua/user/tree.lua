local tree_cb = require'nvim-tree.config'.nvim_tree_callback

-- nvim_tree_disable_netrw, nvim_tree_auto_close, nvim_tree_follow, nvim_tree_bindings, nvim_tree_hide_dotfiles, nvim_tree_ignore
require('nvim-tree').setup({
  nvim_tree_bindings = {
      -- mappings
      {key = {"<CR>", "l", "o", "e"}, cb = tree_cb("edit")},
      -- {"<2-LeftMouse>"} = tree_cb("edit"),
      -- {"<2-RightMouse>"} = tree_cb("cd"),
      {key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
      {key = {"v"}, cb = tree_cb("vsplit")},
      {key = {"-"}, cb = tree_cb("split")},
      {key = {"<C-t>"}, cb = tree_cb("tabnew")},
      {key = {"I"}, cb = tree_cb("toggle_ignored")},
      {key = {"R"}, cb = tree_cb("refresh")},
      {key = {"x"}, cb = tree_cb("cut")},
      {key = {"c"}, cb = tree_cb("copy")},
      {key = {"p"}, cb = tree_cb("paste")},
      {key = {"q"}, cb = tree_cb("close")},
      {key = {"s"}, cb = tree_cb("close")},
      --{"h"} = tree_cb("close_node"),
      --{"<BS>"} = tree_cb("close_node"),
      --{"<S-CR>"} = tree_cb("close_node"),
      --{"<Tab>"} = tree_cb("preview"),
      --{"H"} = tree_cb("toggle_dotfiles"),
      --{"a"} = tree_cb("create"),
      --{"d"} = tree_cb("remove"),
      --{"r"} = tree_cb("rename"),
      --{"<C-r>"} = tree_cb("full_rename"),
      --{"[c"} = tree_cb("prev_git_item"),
      --{"]c"} = tree_cb("next_git_item"),
      --{"-"} = tree_cb("dir_up"),
  },
  filters = {
    hide_dotfiles = 0, --0 by default, this option hides files and folders starting with a dot `.`
    custom = { '.git', 'node_modules', '.cache', '.idea', 'venv', '__pycache__' } --empty by default
  },
  update_focused_file = {
    enable = 1
  },
  disable_netrw = 0, -- 1 by default, disables netrw
  auto_close = 1
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
