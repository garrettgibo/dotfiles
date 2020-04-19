" Automatic reloading of init.vim file
autocmd! bufwritepost ~/.config/nvim/init.vim source %

" Plugins {{{
call plug#begin('~/.config/nvim/bundle')

" Emmet
Plug 'mattn/emmet-vim'

" Seamless tmux vim navigation
Plug 'christoomey/vim-tmux-navigator'

" Highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" Git gutter
" Plug 'airblade/vim-gitgutter'

" Better status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icons
Plug 'ryanoasis/vim-devicons'

" Fuzzy Find
Plug 'ctrlpvim/ctrlp.vim'

" Quick Scope
Plug 'unblevable/quick-scope'

" Nerd Tree
Plug 'scrooloose/nerdtree'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Colorscheme
Plug 'lifepillar/vim-solarized8'

" live markdown
Plug 'shime/vim-livedown'

" better commenteing
Plug 'preservim/nerdcommenter'

" show vertical indentations
" Plug 'Yggdroot/indentLine'

" Better folding
Plug 'tmhedberg/simpylfold'

" Lots of good autocomplete stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()
" }}}

" System {{{
let mapleader=","
set clipboard=unnamed
set mouse=a
set nobackup
set nowritebackup
set noswapfile
set noshowmode
set cmdheight=1
filetype plugin on
set foldmethod=marker

set undofile
set undodir=/tmp/
"}}}

" Searching {{{
set ignorecase
set hlsearch
set showcmd
set showmatch
set mat=2
" }}}

" Formatting {{{
set wrap
set textwidth=80
set scrolloff=10
set colorcolumn=80
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" Default tabbing and indenting
set autoindent          " Auto-indent new lines
set expandtab           " Use spaces instead of tabs
set smartindent         " Enable smart-indent
set smarttab            " Enable smart-tabs
set tabstop=2
set shiftwidth=2        " Number of auto-indent spaces
set softtabstop=2       " Number of spaces per Tab

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
" }}}

" Colors {{{
colorscheme solarized8_high
set background=dark
" }}}

" Better White Space {{{
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
" }}}

" Ctrl-P {{{
let g:ctrl_map = '<c-p>'
let g:ctrl_cmd = 'CtrlP'
" }}}

" {{{ Quick Scope
" Trigger a highlight only when pressing f and F.
let g:qs_highlight_on_keys = ['f', 'F']
" }}}

" Folding {{{
let g:SimpylFold_fold_import=0
" }}}

" Status line {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='atomic'
" }}}

" NerdTree {{{
nmap <C-f> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let g:NERDTreeIgnore = ['^.git$']
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1
" }}}

" Coc {{{
set statusline^=%{coc#status()}

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

nnoremap <silent> <C-y>  :<C-u>CocList -A --normal yank<cr>
inoremap <silent> <C-y>  <ESC>:<C-u>CocList -A --normal yank<cr>
" }}}

" Live Markdown Preview{{{
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 1

" the port on which Livedown server will run
let g:livedown_port = 1234
" }}}

" Nerd Commenter {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
vmap <C-_> <leader>c<Space>
nmap <C-_> <leader>c<Space>
" }}}

" Clipboard with Tmux {{{
let g:clipboard = {
      \   'name': 'myClipboard',
      \   'copy': {
      \      '+': 'tmux load-buffer -',
      \      '*': 'tmux load-buffer -',
      \    },
      \   'paste': {
      \      '+': 'tmux save-buffer -',
      \      '*': 'tmux save-buffer -',
      \   },
      \   'cache_enabled': 1,
      \ }
" }}}

" Autostuff {{{
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
" }}}

" {{{ Diff highlighting
hi DiffAdd      gui=none    guifg=NONE          guibg=#bada9f
hi DiffChange   gui=none    guifg=NONE          guibg=#e5d5ac
hi DiffDelete   gui=bold    guifg=#ff8080       guibg=#ffb0b0
hi DiffText     gui=none    guifg=NONE          guibg=#8cbee2
" }}}

" Emmet {{{
let g:user_emmet_leader_key='<C-e>'
" }}}

" Custom Mappings {{{
noremap q 0
noremap ; $
nnoremap j gj
nnoremap k gk
"nnoremap p "+pa
nnoremap <space> za
vnoremap < <gv
vnoremap > >gv

" Exiting everything with Ctrl-C
inoremap <C-c> <ESC>
nnoremap <C-c> :x<CR>

" Toggle background
map <F5> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Remove search highlight
nnoremap <C-space> :nohl<CR>

" Better pane navigation
map <C-j> <c-w>j
map <C-k> <c-w>k
map <C-l> <c-w>l
map <C-h> <c-w>h
" }}}
