"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
"
" Kacper Kuzniarski personal vimrc config
"
" Note: This line MUST come before any <leader> mappings
let mapleader=","

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" My Plugins here:
" color schemes
Plugin 'joshdick/onedark.vim'

" text-editing heplers
Plugin 'Townk/vim-autoclose'

" ------------------------------------------------------------
Plugin 'terryma/vim-multiple-cursors'

let g:multi_cursor_next_key='<C-n>' "next
let g:multi_cursor_prev_key='<C-k>' "prev
let g:multi_cursor_skip_key='<C-x>' "skip
let g:multi_cursor_quit_key='<Esc>' "quit
" ------------------------------------------------------------
" git
Plugin 'airblade/vim-gitgutter'
" GitGutter
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

Plugin 'git.zip'

" ------------------------------------------------------------
Plugin 'tpope/vim-fugitive'

nmap <Leader>gc :Gcommit<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gp :Git push<CR>
" Mnemonic, gu = Git Update
nmap <Leader>gu :Git pull<CR>
nmap <Leader>gd :Gdiff<CR>
" Exit a diff by closing the diff window
nmap <Leader>gx :wincmd h<CR>:q<CR>
" ------------------------------------------------------------
Plugin 'w0rp/ale'

let g:ale_sign_warning = '◆'
let g:ale_sign_error = '✗'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_linters = {'vue': ['eslint'], 'python': ['flake8', 'pylint'], 'javascript': ['eslint']}
let g:ale_python_flake8_executable = 'flake8'
"let g:ale_python_flake8_options = ''
let g:ale_linters_explicit = 1
let g:ale_echo_msg_format = '[%linter%] %code%: %s'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'always'

highlight link ALEWarningSign String
highlight link ALEErrorSign Title

nmap ]w :ALENextWrap<CR>
nmap [w :ALEPreviousWrap<CR>

nmap <Leader>f <Plug>(ale_fix)

" ------------------------------------------------------------
Plugin 'davidhalter/jedi-vim'
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
" ------------------------------------------------------------
"
" paste/nopaste, fileicoginzer
Plugin 'SuperTab'
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabContextDefaultCompletionType = "<c-n>"


Plugin 'sophacles/vim-bundle-mako'
" files and classes tree
Plugin 'majutsushi/tagbar'  " sudo apt-get install exuberant-ctags

" ------------------------------------------------------------
Plugin 'scrooloose/nerdtree'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vwxyutarooo/nerdtree-devicons-syntax'


nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nm :NERDTreeMirror<CR>
nnoremap <leader>mm :TagbarToggle<CR>

let g:NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2         " Change the NERDTree directory to the root node
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMarkBookmarks = 0
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeStatusLine = -1
let g:NERDTreeIgnore = ['\.pyc$']

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" ------------------------------------------------------------


Plugin 'universal-ctags/ctags'
" searching
" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
Plugin 'junegunn/fzf.vim'
noremap <C-p> :Files<CR>
noremap <F11> :Buffers<CR>

nmap <F12> :b#<CR>
imap <F12> <C-O>:b#<CR>

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

Plugin 'rking/ag.vim'  " sudo apt-get install silversearcher-ag
" ------------------------------------------------------------
Plugin 'itchyny/lightline.vim'
" Lightline
let g:lightline = {
\ 'colorscheme': 'onedark',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

augroup lightline#ale
  autocmd!
  autocmd User ALEJobStarted call s:MaybeUpdateLightline()
  autocmd User ALELintPost call s:MaybeUpdateLightline()
  autocmd User ALEFixPost call s:MaybeUpdateLightline()
augroup END

"autocmd BufWritePost * call s:MaybeUpdateLightline() works after save

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

if !has('gui_running')
    set t_Co=256
endif

" ------------------------------------------------------------
Plugin 'edkolev/tmuxline.vim'
let g:tmuxline_preset = 'lightline'

call vundle#end()
filetype plugin indent on     " required by vundle!


syntax on
colorscheme onedark
set cursorline " highlight current line

" other settings
set nobackup

" ---------------
" UI
" ---------------
set ruler " Ruler on
set nu " Line numbers on
set nowrap " Line wrapping off
set laststatus=2  " always display the status line "
set cmdheight=2
set encoding=utf-8


set noswapfile
set autowrite " Writes on make/shell commands
set timeoutlen=350 " Time to wait for a command (after leader for example)
set foldlevelstart=99 " Remove folds
set formatoptions=crql
" ---------------
" Text Format
" ---------------
set tabstop=4
set backspace=2 " Delete everything with backspace
set shiftwidth=4 " Tabs under smart indent
set cindent
set autoindent
set smarttab
set expandtab
set backspace=2
set softtabstop=4
" ---------------
" Searching
" ---------------
set ignorecase " Case insensitive search
set smartcase " Non-case sensitive search
set incsearch
set hlsearch
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,.sass-cache,*.class
" ---------------
" Visual
" ---------------
set showmatch " Show matching brackets.
set matchtime=2 " How many tenths of a second to blink
" ---------------
" Sounds
" ---------------
set noerrorbells
set novisualbell

" ---------------
" Mouse
" ---------------
set mousehide " Hide mouse after chars typed
"set mouse=a " Mouse in all modes
" ---------------
set number relativenumber

" Better complete options to speed it up
set complete=.,w,b,u,U

" Enable folding
set foldmethod=indent
set foldlevel=99

nnoremap <space><Esc> za
" Enable folding with the spacebar

"split navigations
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h


noremap <F5> <Esc>:syntax sync fromstart<CR>
inoremap <F5> <C-o>syntax sync fromstart<CR>

noremap <F6> <Esc>:%s/\s\+$//e<CR>
inoremap <F6> <C-o>Trailing spaces removed<CR>

set pastetoggle=<F8>

noremap <F10> <Esc>:retab<CR>
inoremap <F10> <C-o>Retab done<CR>

" Edit vimrc with ,v
nmap <silent> <leader>v :e ~/.vimrc<CR>

" ---------------
" Indent Guides
" ---------------
let g:indent_guides_enable_on_vim_startup=1
