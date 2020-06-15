" Automatic reloading of init.vim file
autocmd! bufwritepost ~/.config/nvim/init.vim source %

" Plugins {{{
call plug#begin('~/.config/nvim/bundle')

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Emmet
Plug 'mattn/emmet-vim'

" Seamless tmux vim navigation
Plug 'christoomey/vim-tmux-navigator'

" Highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" Better status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icons
Plug 'ryanoasis/vim-devicons'

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

" Better folding
Plug 'tmhedberg/simpylfold'

" Lots of good autocomplete stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" toggle terminal
Plug 'caenrique/nvim-toggle-terminal'

" jsx colored syntax
Plug 'maxmellon/vim-jsx-pretty'


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
set undofile
set undodir=/tmp/
set foldmethod=marker
set foldlevelstart=20
set foldnestmax=2
"}}}

" Splitting {{{
set splitright
set splitbelow
" }}}

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
    \ set foldmethod=indent |
" }}}

" Colors {{{
colorscheme solarized8_high
set background=dark
" }}}

" Fzf {{{
let g:fzf_layout={'window': { 'width': 0.8, 'height': 0.8, 'xoffset':0.5, 'yoffset':0.5 }}
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

" text search across files
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" text search in file
" command! -bang -nargs=* LP
"   \ call fzf#vim#grep(
"   \  'rg --with-filename --line-number --no-heading --color=always --smart-case . '.fnameescape(expand('%')), 1,
"   \  fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --no-sort'}), <bang>0)

" File search
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" hide status bar on fzf commands
" autocmd! FileType fzf set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Tab through searches
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Normal ctrl-f functionality
map <C-f> :RG<CR>
" rip grep all files
" map <C-g> :RG<CR>
" ctrl-p functionality of vscode
map <C-p> :Files<CR>
" }}}

" Better White Space {{{
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
" }}}

" Folding {{{
let g:SimpylFold_fold_import=0
let g:SimpylFold_fold_docstring=0
let g:SimpylFold_docstring_preview=0
" }}}

" Status line {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='atomic'
" }}}

" NerdTree {{{
nmap <C-e> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let g:NERDTreeIgnore = ['^.git$']
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1
" }}}

" Line Position {{{
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
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
let g:NERDSpaceDelims = 0
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
tnoremap <C-j> <c-w>j
tnoremap <C-k> <c-w>k
tnoremap <C-l> <c-w>l
tnoremap <C-h> <c-w>h

nnoremap <silent> <C-t> :ToggleTerminal<Enter>
tnoremap <silent> <C-t> <C-\><C-n>:ToggleTerminal<Enter>

tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
" }}}
