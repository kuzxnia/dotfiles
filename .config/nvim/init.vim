let mapleader=","                            
                                             
set nocompatible
filetype off

set rtp+=~/.local/share/nvim/plugged
call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'


Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

nmap <Leader>gc :Gcommit<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gp :Git push<CR>
nmap <Leader>gu :Git pull<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gx :wincmd h<CR>:q<CR>
 
Plug 'w0rp/ale'                                                                                        
let g:ale_sign_warning = '◆'                                                                             
let g:ale_sign_error = '✗'                                                                               
let g:ale_echo_msg_error_str = 'E'                                                                       
let g:ale_echo_msg_warning_str = 'W'                                                                     
let g:ale_linters = {'vue': ['eslint'], 'python': ['flake8', 'pylint'], 'javascript': ['eslint']}        
let g:ale_python_flake8_executable = 'flake8'                                                            
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


Plug 'davidhalter/jedi-vim'
let g:jedi#goto_command = "<leader>d"             
let g:jedi#goto_assignments_command = "<leader>g" 
let g:jedi#goto_definitions_command = ""          
let g:jedi#documentation_command = "K"            
let g:jedi#usages_command = "<leader>u"           
let g:jedi#completions_command = "<C-Space>"      
let g:jedi#rename_command = "<leader>r"           

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python'

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nm :NERDTreeMirror<CR>
nnoremap <leader>mm :TagbarToggle<CR>

let g:NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMarkBookmarks = 0
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeStatusLine = -1
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
" let g:NERDTreeDirArrowExpandable='►'
" let g:NERDTreeDirArrowCollapsible='▼'
let g:NERDTreeIgnore = ['\.pyc$']
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

let g:DevIconsDefaultFolderOpenSymbol=''
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol=''

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


Plug 'KeitaNakamura/neodark.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'universal-ctags/ctags'
" searching
" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'
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

Plug 'rking/ag.vim'  " sudo apt-get install silversearcher-ag
" ------------------------------------------------------------
Plug 'itchyny/lightline.vim'
" Lightline
let g:lightline = {
\ 'colorscheme': 'neodark',
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


Plug 'edkolev/tmuxline.vim'
let g:tmuxline_preset = 'lightline'

call plug#end()

set cursorline

syntax on
colorscheme neodark
let g:neodark#background = '#202020'

" other settings
set nobackup

set ruler
set nu
set nowrap
set laststatus=2
set cmdheight=2
set encoding=utf-8


set noswapfile
set autowrite
set timeoutlen=350
set foldlevelstart=99
set formatoptions=crql
" ---------------
" Text Format
" ---------------
set tabstop=4
set backspace=2
set shiftwidth=4
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
set mousehide
set number relativenumber

set complete=.,w,b,u,U
set foldmethod=indent
set foldlevel=99

set pastetoggle=<F8>

"split navigations
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h


noremap <F5> <Esc>:syntax sync fromstart<CR>
inoremap <F5> <C-o>syntax sync fromstart<CR>
noremap <F6> <Esc>:%s/\s\+$//e<CR>
inoremap <F6> <C-o>Trailing spaces removed<CR>
noremap <F10> <Esc>:retab<CR>
inoremap <F10> <C-o>Retab done<CR>
nmap <silent> <leader>v :e ~/.config/nvim/init.vim<CR> 

let g:indent_guides_enable_on_vim_startup=1
