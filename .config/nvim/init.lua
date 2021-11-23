--- SHORTCUTS ---
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local u = require('utils')

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
--- END SHORTCUTS ---

--- PLUGINS ---
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- themes, and syntax
  use 'Mofiqul/vscode.nvim'
  use 'navarasu/onedark.nvim'
  use 'sheerun/vim-polyglot'
  --use 'numirias/semshi'
  use 'ryanoasis/vim-devicons'
  use 'bryanmylee/vim-colorscheme-icons'
  use 'LunarVim/onedarker.nvim'
  -- LSP                           
  use "glepnir/lspsaga.nvim"
  use 'neovim/nvim-lspconfig'      
  use 'hrsh7th/nvim-compe'      
  use 'onsails/lspkind-nvim'       
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  -- use 'jose-elias-alvarez/null-ls.nvim'
  use "RRethy/vim-illuminate"  -- highlights and allows moving between variable references
  -- Git
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }
  -- explorer, line
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'hoob3rt/lualine.nvim'
  -- fuzzy, browse files
  use 'brooth/far.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- might require make clean && make in ~/.local/share/nvim/site/pack/../start/telescope-fzf-native.nvim

  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require"telescope".load_extension("frecency")
    end,
    requires = {"tami5/sqlite.lua"}
  }
  -- See what keys do like in emacs
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }
  -- naviagation
  use {
    'AckslD/nvim-whichkey-setup.lua',
    requires = {'liuchengxu/vim-which-key'},
  }
  use 'christoomey/vim-tmux-navigator'
  use 'justinmk/vim-sneak'
  -- debugging
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'theHamsta/nvim-dap-virtual-text'  
  use 'rcarriga/nvim-dap-ui'
  -- other
  use {
    'iamcco/markdown-preview.nvim', 
    run = function()
      vim.cmd[[mkdp#util#install()]]
      -- or if not worked :call mkdp#util#install()
    end
  }
  -- markdown
  use '907th/vim-auto-save'
  use 'farmergreg/vim-lastplace'
  use 'wellle/tmux-complete.vim'
  use 'b3nj5m1n/kommentary'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use "windwp/nvim-autopairs"
end)
--- END PLUGINS ---

--- GLOBALS ---
vim.g.mapleader = ' '
----- options ----
vim.cmd[[set cursorline ruler nu nowrap laststatus=2 encoding=utf-8]]
vim.cmd[[set noswapfile autowrite timeoutlen=300 foldlevelstart=99 formatoptions=crql]]
-- text format
vim.cmd[[setlocal conceallevel=3]]
vim.cmd[[set tabstop=4 backspace=2 shiftwidth=4 cindent autoindent smarttab expandtab backspace=2 softtabstop=4 ]]
-- searching
vim.cmd[[set ignorecase smartcase incsearch hlsearch]]
vim.cmd[[set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,.sass-cache,*.class]]
-- sounds
vim.cmd[[set noerrorbells novisualbell]]
-- mouse
vim.cmd[[set mousehide complete=.,w,b,u,U foldmethod=indent foldlevel=99]]
-- performance tweaks
vim.cmd[[set nocursorcolumn scrolljump=5 lazyredraw redrawtime=10000 synmaxcol=180 re=0]]
-- required by coc
vim.cmd[[set hidden nobackup nowritebackup cmdheight=2 updatetime=300 shortmess+=c signcolumn=yes]]
-- status line
vim.cmd[[set cmdheight=1]]
vim.cmd[[set t_Co=256]]
vim.cmd[[set t_ut=]]
--- END GLOBALS ---

--vim.g.material_style = "darker"
vim.cmd[[colorscheme onedarker]]
--require('onedarker').setup()
--
--g.vscode_style = "dark"
--cmd('colorscheme vscode')
--vim.cmd[[colorscheme vscode]]

require("nvim-autopairs").setup({})

require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = false, -- auto select first item
})

require('gitsigns').setup()

-- telescope aka fzf
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
    frecency = {
      db_root = "/home/kkuzniarski/.local/share/nvim",
      show_scores = false,
      show_unindexed = true,
      ignore_patterns = {"*.git/*", "*/tmp/*"},
      disable_devicons = false,
      workspaces = {
        ["colonade"]    = "/home/kkuzniarski/workspace/colonnade",
      }
    }
  },
  pickers = {
    default = {
      find_command = {'rg', '--ignore', '--hidden', '--files', '--no-ignore-vcs'},
    },
    buffers = {
      sort_lastused = true
    }
  }
}

require('telescope').load_extension('fzf')

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

-- vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>lua require('telescope').extensions.frecency.frecency()<CR>", {noremap = true, silent = true})
map('n', '<leader><space>', ':lua telescope_files_or_git_files()<CR>')
map('n', '<leader>fd', ':lua telescope_find_files_in_path()<CR>')
map('n', '<leader>fD', ':lua telescope_live_grep_in_path()<CR>')
--map('n', "<leader>fe', ':lua telescope_live_grep_in_path('venv')<CR><CR>")
--map('n', '<leader>ft', ':lua telescope_find_files_in_path("./tests")<CR>')
--map('n', '<leader>fT', ':lua telescope_live_grep_in_path("./tests")<CR>')
map('n', '<leader>fg', ':lua telescope_live_grep_git()<CR>')
map('n', '<leader>fG', ':Telescope live_grep<CR>')
map('n', '<leader>fo', ':Telescope file_browser<CR>')
map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fb', ':Telescope buffers<CR>')
-- for which-key display
map('n', '<leader>b', ':Telescope buffers<CR>')
map('n', '<leader>fs', ':Telescope lsp_document_symbols<CR>')
map('n', '<leader>fbb', ':Telescope git_branches<CR>')

u.command("LspRef", "Telescope lsp_references")
u.command("LspDef", "Telescope lsp_definitions")
u.command("LspSym", "Telescope lsp_workspace_symbols")
u.command("LspAct", "Telescope lsp_code_actions")

-- tmux navigator 
vim.g.tmux_navigator_no_mappings = 1

vim.api.nvim_set_keymap('n', '<M-h>', ':TmuxNavigateLeft<CR>',  {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<M-j>', ':TmuxNavigateDown<CR>',  {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<M-k>', ':TmuxNavigateUp<CR>',    {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<M-l>', ':TmuxNavigateRight<CR>', {noremap = true, silent = true})

--- END LSP ---
-- LSP config (the mappings used in the default file don't quite work right)
require('lspkind').init({ 
    with_text = false,    
    symbol_map = {        
      Class = " ",
      Color = " ",
      Constant = "ﲀ ",
      Constructor = " ",
      Enum = "練",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = "",
      Folder = " ",
      Function = " ",
      Interface = "ﰮ ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Operator = "",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      Struct = " ",
      Text = " ",
      TypeParameter = " ",
      Unit = "塞",
      Value = " ",
      Variable = " ",
    },                    
})

-- LSP this is needed for LSP completions in CSS along with the snippets plugin
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- LSP Server config
require("lspconfig").cssls.setup({
  cmd = { machineCmd, "--stdio" },
  capabilities = capabilities,
  settings = {
    scss = {
      lint = {
        idSelector = "warning",
        zeroUnits = "warning",
        duplicateProperties = "warning",
      },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    },
  },
})

require('lsp')
local saga = require("lspsaga")
saga.init_lsp_saga({
  code_action_icon = " ",
  definition_preview_icon = "  ",
  dianostic_header_icon = "   ",
  error_sign = " ",
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  hint_sign = "⚡",
  infor_sign = "",
  warn_sign = "",
  border_style = "round",
})

vim.lsp.diagnostic.show_line_diagnostics()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
  }
)
vim.api.nvim_exec([[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]], false)
vim.api.nvim_exec([[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]], false)

opt.completeopt = "menuone,noselect"

require('compe').setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  resolve_timeout = 800,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = {
    border = { "", "", "", " ", "", "", "", " " }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  },
  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  },
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  --elseif vim.fn.call("vsnip#available", {1}) == 1 then
  --  return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  --elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
  --  return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
--- END LSP ---

--- LINE ---
local status, lualine = pcall(require, "lualine")
if (not status) then return end
lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'vscode',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
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
  extensions = {'fugitive'}
}
--- END LINE ---

-- kommentary
vim.g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("x", "<leader>c", "<Plug>kommentary_visual_default", {})

-- sneak
vim.g['sneak#label'] = 1
vim.g['sneak#use_ic_scs'] = 1
vim.g['sneak#s_next'] = 1
vim.cmd[[highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan]]
vim.cmd[[highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow]]
vim.g['sneak#prompt'] = '🔎'

-- autosave
vim.g.auto_save = 1
vim.g.auto_save_silent = 1
vim.g.auto_save_events = {"InsertLeave", "TextChanged", "FocusLost"}

vim.cmd[[set clipboard+=unnamedplus]]
-- Copy to clipboard
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', {expr = true})
vim.api.nvim_set_keymap("n", "<leader>Y", '"+yg_', {expr = true})
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', {expr = true})
vim.api.nvim_set_keymap("n", "<leader>yy", '"+yy', {expr = true})

-- Paste from clipboard
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', {expr = true})
vim.api.nvim_set_keymap("n", "<leader>P", '"+P', {expr = true})
vim.api.nvim_set_keymap("v", "<leader>p", '"+p', {expr = true})
vim.api.nvim_set_keymap("v", "<leader>P", '"+P', {expr = true})

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- syntax
-- vim.g.polyglot_disabled = {'python'}
-- vim.g['semshi#error_sign'] = false

vim.api.nvim_set_keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache', '.idea', 'venv', '__pycache__' } --empty by default
vim.g.nvim_tree_disable_netrw = 0 --"1 by default, disables netrw
-- vim.g.nvim_tree_hijack_netrw = 0 --"1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
vim.g.nvim_tree_hide_dotfiles = 0 --0 by default, this option hides files and folders starting with a dot `.`
vim.g.nvim_tree_indent_markers = 1 --"0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_follow = 1 --"0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_auto_close = 0 --0 by default, closes the tree when it's the last window
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
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
}
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

-- which key
local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    f = {
      name = "Find in files",
      f = { "<cmd>Telescope find_files<cr>", "Find file" },
      -- d = { "<cmd>Telescope find_files<cr>", "Find file in directory" },
      g = { "<cmd>lua telescope_live_grep_git()<CR>", "Search in files git" },
      G = { "<cmd>Telescope live_grep<cr>", "Search in files" },
      e = { "<cmd>lua telescope_live_grep_in_path('venv')<CR>", "Search in files in virtual enviroment" },
      b = { "<cmd>Telescope buffers<cr>", "Find buffers" },
      B = { "<cmd>Telescope git_branches<cr>", "Find branches" },
      o = { "<cmd>Telescope file_browser<cr>", "File browser" },

    },
    ["<space>"] = { "<cmd>lua telescope_files_or_git_files()<CR>", "Find file git" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    g = {
      name = "Git",
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
      d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
    },
    d = {
      name = "Debugger",
      c = { "<cmd>lua require 'dap'.continue()<CR>", "Continue/Start session"},
      b = { "<cmd>lua require 'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
      q = { "<cmd>lua require 'dap'.disconnect({ terminateDebuggee = true }); require 'dap'.close(); require 'dapui'.close()<CR>", "Disconnect" },
      r = { "<cmd>lua require 'dap'.disconnect({ terminateDebuggee = true }); require 'dap'.close(); require 'dapui'.close(); require 'dap'.continue()<CR>", "Reconnect" },
      o = { "<cmd>lua require 'dap'.step_out()<CR>", "Step out" },
      i = { "<cmd>lua require 'dap'.step_into()<CR>", "Step into" },
      v = { "<cmd>lua require 'dap'.step_over()<CR>", "Step over" },
      u = { "<cmd>lua require 'dap'.up()<CR>", "Up" },
      d = { "<cmd>lua require 'dap'.down()<CR>", "Down" },
      l = {
        name = "+Lists",
        b = { "<cmd>Telescope dap list_breakpoints<CR>", "Breakpoints list" },
        c = { "<cmd>Telescope dap commands<CR>", "Commands List" },
      },
      t = { "<cmd>lua require 'dapui'.toggle()<CR>", "Toggle UI"},
    },
    s = {
      name = "Search",
      c = { "<cmd>nohlsearch<CR>", "Clear search highlight" },
    },
    m = {
      name = "Markdown",
      p = { "<cmd>MarkdownPreview<CR>", "Preview"},
      s = { "<cmd>MarkdownPreviewStop<CR>", "Preview stop"},
      t = { "<cmd>MarkdownPreviewToggle<CR>", "Preview toggle"},
    }
  },
})

--- DAP - DEBUGGER ---
local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = vim.loop.cwd() .. '/venv/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    name = "Django";
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    args = {
      "runserver",
      "--nothreading",
      "--noreload"
    };
    program = "${workspaceFolder}/manage.py";
    django = true;
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}
require('dap-python').setup(vim.loop.cwd() .. '/venv/bin/python')

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

-- map('n', '<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
--[[ map('n', '<leader>di', ':lua require"dap.ui.variables".hover()<CR>')
map('n', '<leader>di', ':lua require"dap.ui.variables".visual_hover()<CR>')
map('n', '<leader>d?', ':lua require"dap.ui.variables".scopes()<CR>')
map('n', '<leader>di', ':lua require"dap.ui.widgets".hover()<CR>')
map('n', '<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>') ]]
-- map('n', '<leader>d?', ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')

-- nvim-telescope/telescope-dap.nvim
require('telescope').load_extension('dap')
--map('n', '<leader>ds', ':Telescope dap frames<CR>')

-- theHamsta/nvim-dap-virtual-text and mfussenegger/nvim-dap
g.dap_virtual_text = true

-- ui
require("dapui").setup()
--- END DAP - DEBUGGER ---
