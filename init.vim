
filetype plugin indent on
syntax on

call plug#begin('~/.local/share/nvim/plugged')

" ColorScheme
Plug 'jonathanfilip/vim-lucius'
Plug 'altercation/vim-colors-solarized'

" Typescript
Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'

" Python
Plug 'davidhalter/jedi'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-vinegar'

" html
Plug 'mattn/emmet-vim'
" json
Plug 'elzr/vim-json'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neomake/neomake'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'sjl/gundo.vim'
Plug 'chrisbra/Recover.vim'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'mileszs/ack.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'

call plug#end()

colorscheme lucius
set background=dark
set tabstop=2 shiftwidth=2 expandtab
set scrolloff=5   " always keep 5 lines visible above/below cursor
set number
set relativenumber
set scrolloff=5   " always keep 5 lines visible above/below cursor
syntax sync minlines=256 "scroll perf
set smartcase
set magic
set pastetoggle=<F2>
set laststatus=2
set omnifunc=syntaxcomplete#Complete

" folding
set foldmethod=syntax
set foldlevel=6

" history
set history=10000         " remember more commands and search history
set undolevels=10000      " use many muchos levels of undo
set undofile
set undodir="$HOME/.vim_undo"

" no ex mode
nnoremap Q <nop>

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <leader>x :x!<cr>
nnoremap <leader>q :q<CR>

" vimrc
nmap <silent> <leader>ev :vs $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

nnoremap j gj
nnoremap k gk

" windows and tabs
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
noremap <leader>= 10<C-W>+
noremap <leader>- 10<C-W>-
noremap <leader>> 20<C-W>>
noremap <leader>< 20<C-W><
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tm :tabmove<CR>
nnoremap <leader>tc :tabclose<CR>

" Move a line of text using leader+[jk]
vmap <leader>j :m'>+<cr>`<my`>mzgv`yo`z
nmap <leader>k mz:m-2<cr>`z
nmap <leader>j mz:m+<cr>`z
vmap <leader>k :m'<-2<cr>`>my`<mzgv`yo`z

set wildmode=list:full
set wildignore+=*node_modules/**
set wildignore+=*dist/**
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" faster scrolling
nnoremap <C-E> 5<C-E>
nnoremap <C-Y> 5<C-Y>

"""""
" Search
"""""
set ignorecase
set smartcase

" search word under cursor
nnoremap gr :Ag <C-R><C-W><CR>

"""""
" location & quickfix
"""""
" wrap :cnext/:cprevious and :lnext/:lprevious
function! WrapCommand(direction, prefix)
  if a:direction == "up"
    try
      execute a:prefix . "previous"
    catch /^Vim\%((\a\+)\)\=:E553/
      execute a:prefix . "last"
    catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
    endtry
  elseif a:direction == "down"
    try
      execute a:prefix . "next"
    catch /^Vim\%((\a\+)\)\=:E553/
      execute a:prefix . "first"
    catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
    endtry
  endif
endfunction

" <Home> and <End> go up and down the quickfix list and wrap around
nnoremap <silent> [q :call WrapCommand('up', 'c')<CR>
nnoremap <silent> ]q  :call WrapCommand('down', 'c')<CR>

" <C-Home> and <C-End> go up and down the location list and wrap around
nnoremap <silent> [l :call WrapCommand('up', 'l')<CR>
nnoremap <silent> ]l  :call WrapCommand('down', 'l')<CR>


"""""
" autoformat
"""""
nnoremap <leader>f :Autoformat<CR>

"""""
" terminal
"""""
tnoremap <ESC> <C-\><C-n>

"""""
" deoplete
"""""
let g:deoplete#enable_at_startup = 1
let g:deoplete#max_menu_width = 60
inoremap <expr><C-u> deoplete#undo_completion()

"""""
" neomake
"""""
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2

"""""
" typescript
"""""
let g:nvim_typescript#max_completion_detail = 100
let g:nvim_typescript#default_mappings = 1
let g:nvim_typescript#loc_list_item_truncate_after = 50
" autocmd BufWritePost *.ts :TSGetErr
autocmd filetype typescript nnoremap <leader>i :TSImport<CR>
autocmd filetype typescript inoremap II <ESC>:TSImport<CR>
autocmd filetype typescript nnoremap <silent> <leader>gt :TSType <cr>
let g:neomake_typescript_enabled_makers = ['tsc']

"""""
" python
"""""
autocmd FileType python let g:jedi#goto_command = "<c-]>"

"""""
" completion
"""""
set completeopt-=preview
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"""""
" FZF
"""""
nnoremap <C-P> :FZF<CR>
nnoremap <C-G> :GitFiles<CR>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

"""""
" gundo
"""""
let g:gundo_prefer_python3 = 1
nnoremap <F11> :GundoToggle<CR>

"""""
" fugitive
"""""
nnoremap <leader>gs :Gstatus<CR>10<C-W>+
nnoremap <leader>gd :Gvdiff<CR>

"""
" Airline
"""
let g:airline_powerline_fonts = 1
let g:airline_theme='lucius'
let g:airline#extensions#tabline#enabled = 1

let g:airline_mode_map = {
      \ 'n': 'N',
      \ 'i': 'I',
      \ 'v': 'v',
      \ 'V': 'V',
      \ 'r': 'R'
      \ }

"let g:airline_section_x = "%{expand('%:p:.')}"
"let g:airline_section_y = "%{fnamemodify(getcwd(), ':t')}"
"let g:airline_section_c = "%{expand('%:t')}"

"""""
" hacks :(
"""""

" ctrl-h does not work
if has('nvim')
  nmap <BS> <C-W>h
endif


"""""
" Debug vim
"""""
let g:deoplete#enable_debug = 0
let g:deoplete#enable_profile = 0
" call deoplete#enable_logging('DEBUG', '~/.deoplete.log')
