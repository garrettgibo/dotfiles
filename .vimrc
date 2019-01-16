"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"				General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000			" set how many lines in histoy for vim
set path+=**
set autoread				        " set auto read when a file is changed
set fileformats=unix,dos,mac		" Open files from mac/dos
set secure				            " Disable unsafe commands in .vimrc
let mapleader=","			        " Extra key combination

filetype off
syntax on				            " Enable syntax
syntax enable

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'


call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"				key bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Up> :vertical resize +5 <CR>
map <Down> :vertical resize -5 <CR>

" change splits
map H <C-W>h
map L <C-W>l
map J <C-W>j
map K <C-W>k

" remap move to start and end of line
map q 0
map ; $

nnoremap <F3> :call Header()<CR>
nnoremap <F4> :call FunctionHeading()<CR>

map <C-Left> :vert term<CR>
map <C-T> :term<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"				VIM Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu				        " Turn on wild menu
set wildignore=*.0,*~,*.pyc		    " Ignored compiled files
set wildmode=list:longest,full		" Auto-completes longest common command
set ignorecase				        " Ignore case when searching
set incsearch
set hlsearch				        " Highlight search results
set showcmd				            " Shows what command you are typing
set showmatch				        " Display matching brackets
set mat=2				            " Blink when matching brackets
set hidden				            " Don't unload buffer
set number relativenumber		    " Line numbers


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Indenting/ line formating
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent				        " Line numbers
set smartindent				        " Enable smart indent
set shiftwidth=4			        " Enable shift width in 3 spaces
set tabstop=4				        " Tab is 3 spaces
set expandtab				        " Expand the tab
set textwidth=80			        " Text width is 80
set scrolloff=10			        " 10 lines above and below cursor
set wrap				            " Wrap lines

set tags=~/.vim/mytags



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"				Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"colorscheme elflord
"colorscheme desert
"colorscheme slate
colorscheme darkblue


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"				Undo/Backup/SWP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'"""
set undofile				        " Undo's file
set undodir=$HOME/.vim/undo		    " Need a directory in home./vim undo
set undolevels=1000			        " Maximum number of changes
set undoreload=10000			    " Maximum number lines to save for undo
set noswapfile				        " No swap file


augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave ?* mkview
  autocmd BufWinEnter ?* silent loadview
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              function commment mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function Header()
    let s:line=(".")
    call setline(s:line,'/*')
    call append( s:line,' */')
    call append( s:line,' * Sources of Help: TODO')
    call append( s:line,' * Description: TODO')
    call append( s:line,' * UserId: cs30fjl')
    call append( s:line,' * Date: TODO')
    call append( s:line,' * Author: Garrett Gibo')
    call append( s:line,' * Filename: TODO')
    unlet s:line
endfunction

function FunctionHeading()
    let s:line=(".")
    call setline(s:line, '/*')
    call append( s:line, ' */')
    call append( s:line, ' * Return Value: TODO')
    call append( s:line, ' * Error Conditions: TODO')
    call append( s:line, ' * Side Effects: TODO')
    call append( s:line, ' * Parameters: TODO')
    call append( s:line, ' * Description: TODO')
    call append( s:line, ' * Function Prototype: TODO')
    call append( s:line, ' * Function Name: TODO')
    unlet s:line
endfunction


