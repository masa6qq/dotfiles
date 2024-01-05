" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required)
let s:dein_base = '/Users/masakimurakami/.local/share/dein'

" Set Dein source path (required)
let s:dein_src = '/Users/masakimurakami/.local/share/dein/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('ayu-theme/ayu-vim')
call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
call dein#add('cohama/lexima.vim')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-rails')
call dein#add('scrooloose/nerdtree')
call dein#add('907th/vim-auto-save')

" Finish Dein initialization (required)
call dein#end()

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Uncomment if you want to install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

" -----------------------
" Color Scheme
" -----------------------

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let ayucolor="dark"
colorscheme ayu

" -----------------------
" Settings
" -----------------------

" Show line numbers
set number

" Tab
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" Enable auto save
if expand("%:p") =~ 'COMMIT_EDITMSG'
  let g:auto_save = 0
else
  let g:auto_save = 1
endif

" Do not wrap text
set nowrap

filetype plugin indent on

" -----------------------
" Key maps
" -----------------------

" Show files
nnoremap <C-p> :FZF<CR>

" Set left and right keys in insert mode
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" Set jj as ESC
inoremap <silent> jj <ESC>

" Set NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
