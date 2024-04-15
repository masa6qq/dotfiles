" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required)
let s:dein_base = '~/.local/share/dein'

" Set Dein source path (required)
let s:dein_src = '~/.local/share/dein/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" General
call dein#add('ayu-theme/ayu-vim')
call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
call dein#add('scrooloose/nerdtree')
call dein#add('cohama/lexima.vim')
call dein#add('tpope/vim-endwise')
call dein#add('prabirshrestha/asyncomplete.vim')
call dein#add('prabirshrestha/asyncomplete-lsp.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

" Ruby / Rails
call dein#add('tpope/vim-rails')

" HTML / JavaScript / TypeScript
call dein#add('pangloss/vim-javascript')
call dein#add('othree/yajs.vim')
call dein#add('othree/html5.vim')
call dein#add('MaxMEllon/vim-jsx-pretty')

" LSP
call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')

" Git
call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-fugitive')

" Other
call dein#add('mattn/vim-starwars')

" Finish Dein initialization (required)
call dein#end()

" Enable syntax highlighting
if has('syntax')
  syntax on
  set re=0
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

let g:airline_theme='ayu_dark'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

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

" Auto read when modify editing file
set autoread

" Do not wrap text
set nowrap

filetype plugin indent on

" Disable auto comment out when add line
set formatoptions-=ro
autocmd FileType * setlocal formatoptions-=ro

" Show highlight search
set hlsearch
set incsearch

" Show hit count
set shortmess-=S

" Set multiple cursor shapes
if has('vim_starting')
  let &t_SI .= "\e[6 q"
  let &t_EI .= "\e[2 q"
  let &t_SR .= "\e[4 q"
endif

" Always show hidden files in NERDTree
let NERDTreeShowHidden=1

" -----------------------
" Key maps
" -----------------------

" Show files
nnoremap <C-p> :FZF<CR>

" New line
inoremap <C-j> <ESC>$o

" Set jj as ESC
inoremap <silent> jj <ESC>

" Set NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Command line window
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

" LSP
nnoremap gd :LspDefinition<CR>

" -----------------------
" matchit
" -----------------------

" Enable
packadd! matchit

let b:match_words = '\<if\>:\<endif\>,'
      \ . '\<while\>:\<continue\>:\<break\>:\<endwhile\>,'
      \ . '\<if\>:\<end\>,'
      \ . '\<do\>:\<end\>'

" -----------------------
" LSP
" -----------------------

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 200

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 200
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_settings_filetype_ruby = ['solargraph', 'rubocop-lsp-mode']
let g:lsp_settings_filetype_javascript = ['typescript-language-server', 'eslint-language-server']
let g:lsp_settings_filetype_javascriptreact = ['typescript-language-server', 'eslint-language-server']
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']
let g:lsp_settings_filetype_typescriptreact = ['typescript-language-server', 'eslint-language-server']
let g:lsp_settings_filetype_html = ['html-languageserver', 'tailwindcss-intellisense']
let g:lsp_settings_filetype_css = ['css-languageserver', 'tailwindcss-intellisense']
let g:lsp_settings_filetype_scss = ['css-languageserver', 'tailwindcss-intellisense']
let g:lsp_settings_filetype_sql = ['sql-language-server']
let g:lsp_settings_filetype_yaml = ['yaml-language-server']

let g:lsp_log_verbose = 0
