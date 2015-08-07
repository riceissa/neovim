set nocompatible
syntax enable
let mapleader=' '

" Main options
" ======================================================================
set noautoread
set background=light
set backspace=indent,eol,start
set cmdheight=2
set complete-=i
" Show last line instead of the @ column
set display=lastline
set encoding=utf-8
set formatoptions=tcqj
set hidden
set history=10000
set langnoremap
" Show invisible characters
set list
set listchars=nbsp:_,tab:>-,trail:@
set mouse=a
set nrformats=hex
set number
set ruler
set scrolloff=5
set sessionoptions-=options
set showcmd
set showmatch
" Show mode name on status line
set showmode
set smarttab
set nospell
set spellfile=~/.spell.en.add
if &tabpagemax < 50
  set tabpagemax=50
endif
set tags=./tags;,tags
set title
set ttyfast
set viminfo+=!
set wildmenu
set wildmode=list:longest,full
set wrap

" Indenting options
" -----------------
set autoindent
set nocindent
set nosmartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set shiftround

" Searching options
" -----------------
set nohlsearch
set incsearch
" Sane casing
set ignorecase
set smartcase

" Maps
" ======================================================================
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k
" Make Y act like D and C
nnoremap Y y$
nnoremap Q @@
nnoremap <Enter> o<Esc>
" Easy editing of vimrc
nnoremap <silent> <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

" Tabs
" ----
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-n> :tabn<CR>
nnoremap <silent> <C-p> :tabp<CR>

" Windows
" -------
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffers
" -------
nnoremap K :bn<CR>
nnoremap _ :bp<CR>

" Option toggling (similar to vim-unimpaired)
" -------------------------------------------
nnoremap <silent> coh :set hlsearch!<CR>
nnoremap <silent> col :set list!<CR>
nnoremap <silent> con :set number!<CR>
nnoremap <silent> cop :set paste! paste?<CR>
nnoremap <silent> cos :set spell! spell?<CR>
function! ToggleSyntax()
    " See :h syntax for the code
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction
nnoremap <silent> coy :call ToggleSyntax()<CR>

" Format visually selected region to be up to width characters
function! FormatText(width)
    let tempwidth = &textwidth
    let &textwidth=a:width
    normal gvgq
    let &textwidth=tempwidth
endfunction
vnoremap fms <Esc>:call FormatText(72)<CR>
vnoremap fme <Esc>:call FormatText(80)<CR>
vnoremap fmt <Esc>:call FormatText(80)<CR>
vnoremap fmo <Esc>:call FormatText(100)<CR>

function! PasteLink()
    let link = @+
    let command = 'autolink.py "' . link . '"'
    return system(command)
endfunction
inoremap <C-l> <C-r>=PasteLink()<CR>

" Paste HTML as Pandoc markdown; remember as 'markdown paste'
nnoremap <leader>mp :r !xclip -sel clip -t text/html -o \| pandoc -f html -t markdown<CR>

" Other options
" ======================================================================
" Change pwd to directory of current file
command! CD :cd %:p:h
" Make <C-c>, <C-v> work as expected
silent !stty -ixon > /dev/null 2>/dev/null
source ~/.vim/mswin_extract.vim

" HTML options
" ------------
augroup filetype_html
    autocmd!
    autocmd filetype html setlocal shiftwidth=2 softtabstop=2 tabstop=2
    autocmd filetype xhtml setlocal shiftwidth=2 softtabstop=2 tabstop=2
    autocmd filetype xml setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

" Custom digraphs
" ---------------
" Use Python's ord() to obtain the integer value of a character. Hit
" <C-k> in insert mode then type the characters following 'dig' to produce
" the special character.

" Ellipsis, …
dig el 8230
" Left and right angle brackets, ⟨ ⟩
dig (< 10216
dig <( 10216
dig )> 10217
dig >) 10217