" encode setting                                                                                                                                 
set encoding=utf-8

"syntax enable
colorscheme monokai-tasty

" editor setting
filetype on
filetype plugin on
filetype indent on
syntax on

set ai
set si

set number                                                      " 行番号表示
set splitbelow                                                  " 水平分割時に下に表示
set splitright                                                  " 縦分割時を右に表示
set noequalalways                                               " 分割時に自動調整を無効化
set wildmenu                                                    " コマンドモードの補完
" cursor setting
set ruler                                                       " カーソルの位置表示
set cursorline                                                  " カーソルハイライト
" tab setting
set ts=2 sw=2 sts=2
set expandtab                                                   " tabを複数のspaceに置き換え

set clipboard=unnamed
set guioptions-=M "menubar
set guioptions-=T "toolbar
set guioptions-=r "scrollbar

set hlsearch
set incsearch

" neovim
let mapleader = ","

" ------------------------------------------------------------
" dein.vim set up
" ------------------------------------------------------------
if &compatible
  set nocompatible
endif

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  "call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  let g:config_dir  = expand('~/.vim/dein')
  let s:toml        = g:config_dir . '/plugins.toml'
  let s:lazy_toml   = g:config_dir . '/plugins_lazy.toml'

  " load TOML
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
" airline
let g:airline#extensions#tabline#enabled = 1

" fzf
set rtp+=/usr/local/opt/fzf
nnoremap <silent> ,f :GFiles<CR>
nnoremap <silent> ,F :GFiles?<CR>
nnoremap <silent> ,b :Buffers<CR>
nnoremap <silent> ,l :BLines<CR>
nnoremap <silent> ,h :History<CR>
nnoremap <silent> ,m :Mark<CR>

" deoplete
let g:deoplete#enable_at_startup = 1

" NerdTree
map <C-n> :NERDTreeToggle<CR>
" autocmd vimenter * NERDTree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"let NERDTreeMapOpenInTab='<ENTER>'

