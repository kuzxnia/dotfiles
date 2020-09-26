" plug

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/plugged')

" ___________________________ gui ___________________________
" themes
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'rakr/vim-one'
Plug 'sonph/onehalf', {'rtp': 'vim/'}

" other
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'luochen1990/rainbow'

" ___________________________ functionalities ___________________________

" fuzzy, browse files
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'

" linting, completion
Plug 'w0rp/ale'
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" auto brackets, html tags
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'  " for closing html tags

" languages
Plug 'sheerun/vim-polyglot'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " better python syntax highlight

" git
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'

" other
Plug '907th/vim-auto-save'
Plug 'farmergreg/vim-lastplace'
Plug 'wellle/tmux-complete.vim'

call plug#end()

" ___________________________ configuration ___________________________

colorscheme onedark

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set cursorline ruler nu nowrap laststatus=2 encoding=utf-8
set noswapfile autowrite timeoutlen=350 foldlevelstart=99 formatoptions=crql
" text format
setlocal conceallevel=3
set tabstop=4 backspace=2 shiftwidth=4 cindent autoindent smarttab expandtab backspace=2 softtabstop=4 
" searching
set ignorecase smartcase incsearch hlsearch
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,.sass-cache,*.class
" sounds
set noerrorbells novisualbell
" mouse
set mousehide complete=.,w,b,u,U foldmethod=indent foldlevel=99
" performance tweaks
set nocursorcolumn scrolljump=5 lazyredraw redrawtime=10000 synmaxcol=180 re=1
" required by coc
set hidden nobackup nowritebackup cmdheight=2 updatetime=300 shortmess+=c signcolumn=yes
" status line
set cmdheight=1

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

let g:polyglot_disabled = ['python']

" tmux cursor shape
if exists('$TMUX')
    let &t_SI .= "\ePtmux;\e\e[=1c\e\\"
    let &t_EI .= "\ePtmux;\e\e[=2c\e\\"
 else
    let &t_SI .= "\e[=1c"
    let &t_EI .= "\e[=2c"
endif

" ___________________________ plugins configurations ___________________________

" lightline
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

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" snippets
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger        = "<tab>"
let g:UltiSnipsJumpForwardTrigger   = "<tab>"
let g:UltiSnipsJumpBackwardTrigger  = "<s-tab>"

" ale
let g:ale_sign_warning              = '◆'
let g:ale_sign_error                = '✗'
let g:ale_echo_msg_error_str        = 'E'
let g:ale_echo_msg_warning_str      = 'W'
let g:ale_linters                   = {'vue': ['eslint'], 'python': ['flake8', 'pylint', 'mypy'], 'javascript': ['eslint']}
let g:ale_python_flake8_executable  = 'flake8'
let g:ale_linters_explicit          = 1
let g:ale_echo_msg_format           = '[%linter%] %code%: %s'
let g:ale_lint_on_enter             = 1
let g:ale_lint_on_save              = 1
let g:ale_lint_on_text_changed      = 'always'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" nerdtree
let g:NERDTreeMinimalUI                                  = 1
let g:NERDTreeAutoDeleteBuffer                           = 1
let g:NERDTreeStatusLine                                 = -1
let g:NERDTreeShowHidden                                 = 1
let NERDTreeIgnore                                       =['\.pyc','\~$','\.swp', '\.git$']
let g:DevIconsEnableFoldersOpenClose                     = 1
let g:DevIconsEnableFolderExtensionPatternMatching       = 1
let g:DevIconsDefaultFolderOpenSymbol                    = ''
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
let g:NERDTreeDirArrowExpandable                           = "\u00a0"
let g:NERDTreeDirArrowCollapsible                          = "\u00a0"


autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" auto save
let g:auto_save        = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]

" gitgutter, gitmessenger
let g:gitgutter_sign_added                  = '∙'
let g:gitgutter_sign_modified               = '∙'
let g:gitgutter_sign_removed                = '∙'
let g:gitgutter_sign_modified_removed       = '∙'
let g:git_messenger_into_popup_after_show   = 1
let g:git_messenger_always_into_popup       = 1

" deoplete
let g:deoplete#enable_at_startup                    = 1
let g:deoplete#sources#syntax#min_keyword_length    = 2
let g:python3_host_prog                             = '/usr/bin/python3'
let g:python_host_prog                              = '/usr/bin/python'

" closetag
let g:closetag_filenames    = '*.html,*.xhtml,*.phtml,*.vue,*.md'
let g:closetag_shortcut     = '>'

" startify
let g:startify_session_persistence = 1
let g:startify_fortune_use_unicode = 1
let g:startify_enable_special      = 0

" rainbow brackets
let g:rainbow_active = 1

" auto save
let g:auto_save        = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]

" semshi settings
let g:semshi#error_sign = v:false

" FZF
" general
set rtp+=~/.fzf
let $FZF_DEFAULT_OPTS   = "--reverse "
let g:fzf_layout        = { 'window': 'call CreateCenteredFloatingWindow()' }

" use rg by default
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
endif


" ___________________________ functions ___________________________

" files window with preview
command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" advanced grep(faster with preview)
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" floating fzf window with borders
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction


" ___________________________ mappings ___________________________
let mapleader = ","

"split navigations
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h

" ale, syntax
nmap ]w :ALENextWrap<CR>
nmap [w :ALEPreviousWrap<CR>
nmap <Leader>f <Plug>(ale_fix)

" jedi
let g:jedi#goto_command             = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command    = "K"
let g:jedi#usages_command           = "<leader>u"
let g:jedi#completions_command      = "<C-Space>"
let g:jedi#rename_command           = "<leader>r"

" deoplete, ctrl+j/k instead tab/shift+tab
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" fuzzy search, grep, buffers
noremap <C-f> :Files<CR>
nnoremap <C-g> :Rg<Cr>
noremap <F11> :Buffers<CR>
nmap <F12> :b#<CR>
imap <F12> <C-O>:b#<CR>

" nerdtree
nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nm :NERDTreeMirror<CR>

" git
nmap <Leader>gm <Plug>(git-messenger)

" editor
inoremap <F5> <C-o>Syntax restart<CR>
noremap <F5> <Esc>:syntax sync fromstart<CR>
inoremap <F6> <C-o>Trailing spaces removed<CR>
noremap <F6> <Esc>:%s/\s\+$//e<CR>
" set paste/nopaste
set pastetoggle=<F8>
inoremap <F10> <C-o>Tabs to spaces<CR>
noremap <F10> <Esc>:retab<CR>

" edit neovim config
nmap <silent> <leader>v :e ~/.config/nvim/init.vim<CR>
