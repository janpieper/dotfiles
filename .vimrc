" Disable compatibility mode
set nocompatible

" Use ',' as leader key
let mapleader=','

" Color scheme
set t_Co=256
syntax on
set background=dark
let g:solarized_termtrans=1
let g:solarized_contrast="high"
colorscheme solarized

" Indention
set autoindent
set smartindent

" Use two spaces as tabs
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smarttab

" Do not wrap lines
set nowrap

" 80-column marker
set colorcolumn=80,100,120

" t - autowrap to textwidth
" c - autowrap comments to textwidth
" r - autoinsert comment leader with <Enter>
" q - allow formatting of comments with :gq
" l - don't format already long lines
set formatoptions=tcrql

" lines to scroll when cursor leaves screen
set scrolljump=5

" minimum lines to keep above and below cursor
set scrolloff=3

" Encoding
set encoding=utf-8

" Do not create backup/swap files
set nobackup
set noswapfile

" Ignoring case in a pattern
set ignorecase

" Allow restoring the title
set title

" Show line numbers
set number

" Maximum number of changes that can be undone
set undolevels=1000

" Allow buffer switching without saving
set hidden

" Show matching parathesis/brackets
set showmatch

" Search as you type and highlight matches
set incsearch
set hlsearch

" Enable mouse
set mouse=a

" Center display line after searches
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" 'Very magic' regexes in searches
nnoremap / /\v
nnoremap ? /\v

" Show list instead of just jumping
set wildmenu
set wildmode=list:longest,full

" Hightlight problematic whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Stupid shift key fixes
"cmap W w
"cmap Q q
cmap WQ wq
cmap wQ wq
cmap Wq wq
cmap Tabe tabe

" Quickly edit/reload the .vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Delete without putting content into register
vmap D "_d

" Buffer creation and movement
map <leader>- :split<CR>
map <leader>\| :vsplit<CR>
map <leader>\ :vsplit<CR>
map <leader><left> <C-w><left>
map <leader><right> <C-w><right>
map <leader><down> <C-w><down>
map <leader><up> <C-w><up>

" Buffer movement with <leader> is consistent with tmux but
" somehow "painful" to use and therefore this alternative
map <M-S-Left> <leader><left>
map <M-S-Right> <leader><right>
map <M-S-Down> <leader><down>
map <M-S-Up> <leader><up>

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Tab creation and movement
map <S-t> :tabnew<CR>
map <S-Left> :tabprev<CR>
map <S-Right> :tabnext<CR>

" Allow up to 20 tabs at once
set tabpagemax=20

" For when you forgot to sudo... Really write the file!
cmap w!! w !sudo tee %> /dev/null

" CtrlP
nmap <Leader>u :CtrlPMRUFiles<CR>
let g:ctrlp_map = "<Leader>y"

let g:ctrlp_open_new_file = "r"
let g:ctrlp_cache_dir = $HOME . "/.vim/ctrlp-cache"
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = "\.git$\|\.hg$\|\.svn$"
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_switch_buffer = 2
let g:ctrlp_working_path_mode = 0

" CtrlP - Open files in a new buffer
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

" File IO
" set autoread <-- SEGMENTATION FAULT
" au FocusLost * :wa
" set autowrite

" When vimrc is edited, reload it
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Use system clipboard
set clipboard=unnamedplus

" Additional Ruby Syntax Highlighting
" http://dailyvim.tumblr.com/post/1262764095/additional-ruby-syntax-highlighting
autocmd BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,Stormfile,config.ru,.caprc,.irbrc,irb_tempfile*,*.gemspec,*.thor} set ft=ruby

" BlackBerry QML
autocmd BufRead,BufNewFile {*.qml} set ft=javascript

" Slim Template
autocmd BufRead,BufNewFile {*.slim} set ft=slim

" Java
autocmd FileType java setl sw=4 sts=4 et

" Python
autocmd FileType python setl sw=4 sts=4 et

" Delete trailing white space
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    %s/\%x0d$//ge
    exe "normal `z"
endfunc

" Delete trailing white space on save
autocmd BufWrite * :call DeleteTrailingWS()

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Remember info about open buffers on close
set viminfo^=%

" Keep yanked value if pasted
xnoremap p pgvy

" Toggle auto-indenting for code paste
" http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
set pastetoggle=<F2>

function! CloseAllBuffersExceptCurrent()
  let curr = bufnr("%")
  let last = bufnr("$")

  if curr > 1 | silent! execute "1,".(curr-1)."bd" | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction

nmap <Leader>\c :call CloseAllBuffersExceptCurrent()<CR>

" Autoformat file on save
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END
