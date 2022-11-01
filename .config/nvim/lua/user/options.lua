local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  timeoutlen = 1000,                        -- time to wait for a mapped sequence to complete (in milliseconds) 300 in my config
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  softtabstop = 2,                         -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = false,                  -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd [[ set clipboard+=unnamedplus ]]
vim.cmd [[ set whichwrap+=<,>,[,],h,l ]]
vim.cmd [[ set iskeyword+=- ]]
vim.cmd [[ set formatoptions=crql ]]
vim.cmd [[ nnoremap Y Y ]]

-- colorscheme
vim.cmd[[colorscheme onedark]]
vim.cmd[[highlight Comment cterm=italic gui=italic]]
vim.cmd[[highlight Statement cterm=italic gui=italic]]

-- tmux navigator
vim.g.tmux_navigator_no_mappings = 1

-- kommentary
vim.g.kommentary_create_default_mappings = false

-- autosave
vim.g.auto_save = 1
vim.g.auto_save_silent = 1
vim.g.auto_save_events = {"InsertLeave", "TextChanged", "FocusLost"}

--- GLOBALS ---
vim.g.mapleader = ' '
----- options ----
vim.cmd[[set ruler nu nowrap laststatus=2 ]]
vim.cmd[[set noswapfile autowrite foldlevelstart=99 ]]
-- text format
vim.cmd[[set cindent autoindent smarttab expandtab ]]
vim.cmd[[setlocal conceallevel=3]]
-- indent(spacing) by filetype
vim.cmd[[autocmd Filetype python setlocal ts=4 sw=4 expandtab]]
vim.cmd[[autocmd Filetype javascript setlocal ts=4 sw=4 expandtab]]
vim.cmd[[autocmd Filetype coffescript setlocal ts=4 sw=4 expandtab]]
vim.cmd[[autocmd Filetype html setlocal ts=2 sw=2 expandtab]]
vim.cmd[[autocmd Filetype dart setlocal ts=2 sw=2 expandtab]]
-- searching
vim.cmd[[set ignorecase smartcase incsearch hlsearch]]
vim.cmd[[set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,.sass-cache,*.class]]
-- sounds
vim.cmd[[set noerrorbells novisualbell]]
-- mouse
vim.cmd[[set mousehide mouse= complete=.,w,b,u,U foldmethod=indent foldlevel=99]]
-- performance tweaks
vim.cmd[[set nocursorcolumn scrolljump=5 lazyredraw redrawtime=10000 synmaxcol=180 re=0]]
-- diff 
-- vim.cmd[[set diffopt+=algorithm:patience]]
-- required by coc
vim.cmd[[set hidden nobackup nowritebackup cmdheight=2 updatetime=300 signcolumn=yes]]
-- status line
vim.cmd[[set cmdheight=1]]
vim.cmd[[set t_Co=256]]
vim.cmd[[set t_ut=]]
