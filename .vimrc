syntax on
set ts=4
set sw=4
set sts=4
set et
set ai
set hlsearch
set bg=dark
"set ic
set foldlevelstart=99
set hidden
"set colorcolumn=80

hi ColorColumn ctermbg=3 guibg=#888

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>

noremap <F12> @@<CR>


let mapleader = ","
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

map <F9> <ESC>:tabprevious<CR>
map <F10> <ESC>:tabnext<CR>

map! <F9> <ESC>:tabprevious<CR>
map! <F10> <ESC>:tabnext<CR>

"inoremap <up> g<up>
"inoremap <down> g<down>

map <m-left> <ESC>:tabprevious<CR>
map <m-right> <ESC>:tabnext<CR>

map! <m-left> <ESC>:tabprevious<CR>
map! <m-right> <ESC>:tabnext<CR>
map <C-s> :w<CR>

cabbr te tabedit
cabbr ff FufFile

" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
" match ErrorMsg '\%>80v.\+'

" NERDTree
let NERDTreeShowBookmarks=1

nnoremap j gj
nnoremap k gk
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Remember last position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

