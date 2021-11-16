" plug
"

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

" other
Plug 'ryanoasis/vim-devicons'
Plug 'bryanmylee/vim-colorscheme-icons'
Plug 'itchyny/lightline.vim'
Plug 'luochen1990/rainbow'

" ___________________________ functionalities ___________________________
" fuzzy, browse files
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim'

" linting, completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'tweekmonster/django-plus.vim'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" auto brackets, html tags
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'  " for closing html tags

" languages
" let g:polyglot_disabled = ['python']
Plug 'sheerun/vim-polyglot'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " better python syntax highlight

" git
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'

" other
Plug '907th/vim-auto-save'
Plug 'farmergreg/vim-lastplace'
Plug 'wellle/tmux-complete.vim'

" See what keys do like in emacs
Plug 'liuchengxu/vim-which-key'

" naviagation
Plug 'christoomey/vim-tmux-navigator'
Plug 'unblevable/quick-scope'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

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


" tmux cursor shape
if exists('$TMUX')
    let &t_SI .= "\ePtmux;\e\e[=1c\e\\"
    let &t_EI .= "\ePtmux;\e\e[=2c\e\\"
 else
    let &t_SI .= "\e[=1c"
    let &t_EI .= "\e[=2c"
endif

" ___________________________ plugins configurations ___________________________

" which key
source $HOME/.dotfiles/.config/nvim/plug/which_key.vim

" ale
let g:ale_sign_warning              = ' '
let g:ale_sign_error                = ''
let g:ale_echo_msg_error_str        = 'E'
let g:ale_echo_msg_warning_str      = 'W'
let g:ale_linters                   = {'vue': ['eslint'], 'python': ['flake8', 'pylint', 'mypy'], 'javascript': ['eslint']}
let g:ale_python_flake8_executable  = 'flake8'
let g:ale_linters_explicit          = 1
let g:ale_echo_msg_format           = '[%linter%] %code%: %s'
let g:ale_lint_on_enter             = 1
let g:ale_lint_on_save              = 1
let g:ale_lint_on_text_changed      = 'always'
" highlight link ALEWarningSign String
" highlight link ALEErrorSign Title

" lightline
let g:lightline = {
\ 'colorscheme': 'onedark',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok', 'gitbranch']]
\ },
\ 'component_function': {
\   'gitbranch': 'fugitive#head',
\   'lineinfo': 'LightlineLineinfo',
\   'mode': 'LightlineMode',
\   'filename': 'LightlineFilename',
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

function! LightlineFilename()
    return expand('%:~:.')
endfunction

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d  ', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction

augroup lightline#ale
  autocmd!
  autocmd User ALEJobStarted call s:MaybeUpdateLightline()
  autocmd User ALELintPost call s:MaybeUpdateLightline()
  autocmd User ALEFixPost call s:MaybeUpdateLightline()
augroup END

function! LightlineLineinfo() abort
    if winwidth(0) < 86
        return ''
    endif

    let l:current_line = printf('%-3s', line('.'))
    let l:max_line = printf('%-3s', line('$'))
    let l:lineinfo = ' ' . l:current_line . '/' . l:max_line
    return l:lineinfo
endfunction

function! LightlineMode() abort
    let ftmap = {
                \ 'coc-explorer': 'EXPLORER',
                \ 'fugitive': 'FUGITIVE'
                \ }
    return get(ftmap, &filetype, lightline#mode())
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" semshi settings
let g:semshi#error_sign = v:false

" snippets
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger        = "<tab>"
let g:UltiSnipsJumpForwardTrigger   = "<tab>"
let g:UltiSnipsJumpBackwardTrigger  = "<s-tab>"

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

" closetag
let g:closetag_filenames    = '*.html,*.xhtml,*.phtml,*.vue,*.md'
let g:closetag_shortcut     = '>'

" rainbow brackets
let g:rainbow_active = 1

" auto save
let g:auto_save        = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]

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

" COC
let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-actions',
    \ 'coc-sh',
    \ 'coc-java-debug',
    \ 'coc-java',
    \ 'coc-lists',
    \ 'coc-emmet',
    \ 'coc-tasks',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-floaterm',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-emoji',
    \ 'coc-cssmodules',
    \ 'coc-yaml',
    \ 'coc-python',
    \ 'coc-explorer',
    \ 'coc-svg',
    \ 'coc-prettier',
    \ 'coc-vimlsp',
    \ 'coc-xml',
    \ 'coc-yank',
    \ 'coc-json',
    \ 'coc-marketplace',
    \ ]

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
autocmd!
" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder.
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Explorer
let g:coc_explorer_global_presets = {
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 30,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'right-center',
\      'floating-width': 30,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" tmux navigator 
let g:tmux_navigator_no_mappings = 1

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

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

" coc
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" ___________________________ mappings ___________________________
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

set clipboard+=unnamedplus
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

"split navigations
" nnoremap <M-j> <C-w>j
" nnoremap <M-k> <C-w>k
" nnoremap <M-l> <C-w>l
" nnoremap <M-h> <C-w>h
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>

nnoremap <silent> <tab> gt
nnoremap <silent> <s-tab> gT

" fuzzy search, grep, buffers
noremap <C-f> :Files<CR>
nnoremap <C-g> :Rg<Cr>
noremap <F11> :Buffers<CR>
nmap <F12> :b#<CR>
imap <F12> <C-O>:b#<CR>

" COC
" Use tab for trigger completion with characters ahead and navigate.
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" smart rename
nmap <silent> rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" coc explorer
nmap <silent><space>e :CocCommand explorer<CR>

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

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


" TODO

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)
"
" Mappings using CoCList:
" Show all diagnostics.
" TODO add these to which key
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"

" Snippets
" Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

