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

call plug#begin('~/.config/nvim/plugged')
	Plug 'numToStr/Comment.nvim'
	Plug 'lunarvim/onedarker.nvim'
	Plug 'joshdick/onedark.vim'
	Plug 'itchyny/lightline.vim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
	Plug 'glepnir/dashboard-nvim'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'williamboman/nvim-lsp-installer'
	Plug 'tamago324/nlsp-settings.nvim'
	Plug 'mg979/vim-visual-multi'
call plug#end()

" Set colorscheme, lightline and guicolors
set termguicolors
colorscheme onedarker
let g:lightline = {
\ 'colorscheme': 'onedark',
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' },
\ 'active': {
\   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename' ], [ 'modified' ] ],
\   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
\ },
\}

" Set fzf as fuzzy-finder to dashboard-nvim
let g:dashboard_default_executive = 'fzf'

" Set custom header for dasboard-nvim
let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝'
\]

" Set custom footer for dashboard-nvim
let g:dashboard_custom_footer = [
\ 'Neovim > Vim > Vi > Emacs'
\]

" Disable statusbar when in dashboard
autocmd FileType dashboard set laststatus=0 ruler | autocmd WinLeave <buffer> set laststatus=2

" Dashboard keybindgs
let g:dashboard_custom_shortcut = {
\ 'last_session'       : 'SPC s l',
\ 'find_history'       : 'SPC f h',
\ 'find_file'          : 'SPC f f',
\ 'new_file'           : 'SPC c n',
\ 'change_colorscheme' : 'SPC t c',
\ 'find_word'          : 'SPC f a',
\ 'book_marks'         : 'SPC f b',
\}

let g:mapleader = "\<Space>"
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

lua << EOF
	require('Comment').setup()
	require('lspconfig').pyright.setup({})
	require('nvim-treesitter.configs').setup({
		highlight = {
			enable = true,
			additional_vim_regex_highlight = false
		}
	})

	local opt = { expr = true, remap = true }

	-- Map Ctrl + / to toggle linewise comments in NORMAL, INSERT and VISUAL mode
	vim.keymap.set('n', '', "'<Plug>(comment_toggle_current_linewise)'", opt)
	vim.keymap.set('i', '', "'<ESC><Plug>(comment_toggle_current_linewise)i'", opt)
	vim.keymap.set('x', '', "'<ESC><Plug>(comment_toggle_current_linewise)v'", opt)
EOF


" Map Ctrl + D to use vim-visual-multi
let g:VM_maps = {
\ 'Find Under': '<C-d>',
\ 'Find Subword Under': '<C-d>'
\}

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
