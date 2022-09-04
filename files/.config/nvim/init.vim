" Set tabsize to 2
set tabstop=2
set shiftwidth=2

" Set UTF-8
set encoding=utf-8

" Disable .viminfo
set viminfo='0,:0,<0,@0,f0

" Show line number
set number

" Enable syntax-highlighting
syntax on

" Enable use of mouse
set mouse=a

" Set undofile
set undofile         " Save undos after file close
set undolevels=1000  " How many undos
set undoreload=10000 " Number of lines to save for undo

" Map Ctrl + S to save file
nnoremap <silent> <C-S>	:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>v

" Map Ctrl + Q to quit neovim
nnoremap <silent> <C-Q> :q!<CR>
inoremap <silent> <C-Q> <C-O>:q!<CR>
vnoremap <silent> <C-Q> <C-C>:q!<CR>

" Map Ctrl + Z to undo (trap SIGINT needed)
nnoremap <silent> <C-Z> :u<CR>
inoremap <silent> <C-Z> <C-O>:u<CR>
vnoremap <silent> <C-Z> <C-C>:u<CR>

" Map Ctrl + R to redo in visual and input modes
inoremap <silent> <C-R> <C-O><C-R>
vnoremap <silent> <C-R> <C-C><C-R>
