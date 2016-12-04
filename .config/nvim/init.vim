set encoding=utf-8
set history=700

syntax on
colorscheme mymonokai
let g:rehash256 = 1
let g:molokai_original = 1

filetype on
filetype plugin on
filetype indent on
syntax on

set number
set ruler
set hlsearch
set incsearch

set ts=4 sw=4 sts=4
set expandtab

set ai
set si

set guioptions-=M "menubar
set guioptions-=T "toolbar
set guioptions-=r "scrollbar

set nocompatible

"set <Leader>
let mapleader = "\<Space>"

" save yank to clipboard
set clipboard=unnamed

" code folding
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

"dein{{{
" install when vim is launched
augroup PluginInstall
  autocmd!
  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END

" 各プラグインをインストールするディレクトリ
let s:plugin_dir = expand('~/.config/nvim//bundle/')
"let s:plugin_dir = expand('~/.vim/bundle/')
" dein.vimをインストールするディレクトリをランタイムパスへ追加
let s:dein_dir = s:plugin_dir . 'repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . s:dein_dir

" dein.vimがまだ入ってなければ 最初に`git clone`
if !isdirectory(s:dein_dir)
  call mkdir(s:dein_dir, 'p')
  silent execute printf('!git clone %s %s', 'https://github.com/Shougo/dein.vim', s:dein_dir)
endif

if dein#load_state(s:plugin_dir)
  call dein#begin(s:plugin_dir)

  " installed plugin
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimshell.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/unite-outline')
  call dein#add('shougo/deoplete.nvim')
  call dein#add('majutsushi/tagbar')
  call dein#add('fatih/vim-go')
  "call dein#add('dgryski/vim-godef')
  call dein#add('vim-jp/vim-go-extra')
  call dein#add('nsf/gocode')
  "call dein#add('zchee/deoplete-go')
  call dein#add('zchee/deoplete-go', {'build': 'make'})
  call dein#add('scrooloose/syntastic')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('vim-scripts/nginx.vim')
  call dein#add('ekalinin/Dockerfile.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('qpkorr/vim-bufkill')
  call dein#add('vim-ruby/vim-ruby')

  "
  " if plugin need to be built after install
  call dein#add('Shougo/vimproc.vim', {
        \ 'build': {
        \     'mac': 'make -f make_mac.mak',
        \     'linux': 'make',
        \     'unix': 'gmake',
        \    },
        \ })

  " 条件によって使ったり使わなかったり制御する場合
"  call dein#add('Shougo/neocomplete.vim', {
"        \ 'if' : has('lua')
"        \ })

  " has dependency
  call dein#add('Shougo/unite.vim')
  call dein#add('ujihisa/unite-colorscheme', {'depends' : 'Shougo/unite.vim'})
  call dein#add('Shougo/vimfiler.vim', {'depends' : 'Shougo/unite.vim'})

  "call dein#add('xolox/vim-misc')
  "call dein#add('xolox/vim-lua-inspect', {'depends' : 'xolox/vim-misc'})

  " 手動でcall dein#source('プラグイン名')して使い始める場合
  "  call dein#add('Shougo/vimfiler', {'lazy' : 1})

  " 指定のファイルタイプ使う場合
  "  call dein#add('tpope/vim-rails', {'on_ft' : 'ruby'})

"  " dein.vimで管理して更新だけするリポジトリ（NeoBundleFetchとおなじ）
  " call dein#add('jszakmeister/markdown2ctags', {'rtp': ''})

  " サブディレクトリを指定してdein#add()する場合
  " frozenオプションは自動で更新しない
  " 自分で開発するプラグインの管理に便利
"  call dein#local('~/src/github.com/violetyk',
"        \ {
"        \   'frozen' : 1,
"        \   'depends' : [
"        \     'kana/vim-gf-user',
"        \     'Shougo/neosnippet.vim',
"        \     'vim-jp/vital.vim'
"        \   ]
"        \ },
"        \ [
"        \   '*.vim',
"        \   'neosnippet-*',
"        \   'neocomplete-*',
"        \   'scratch-utility'
"        \ ])
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
"}}}
"
" general {{{
" move among buffers with CTRL
nmap <C-J> :bnext<CR>
nmap <C-K> :bprev<CR>
" }}}

" vim-airline{{{
let g:airline#extensions#tabline#enabled = 1
" }}}

"deoplete{{{
set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect

let g:deoplete#enable_at_startup = 1
" To make deoplete work properly, set python bin explicitly
"let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 1

" automatically close preview window
autocmd CompleteDone * pclose!
"}}}

"golang {{{
set path+=$GOPATH/src/**
"let g:gofmt_command = 'goimports'
let g:gofmt_command = 'gofmt'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_autosave = 1
au BufWritePre *.go Fmt
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4 completeopt=menu,preview
au FileType go compiler go

" deoplete-go
"exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'const', 'type', 'var']
let g:deoplete#sources#go#use_cache = 1
"}}}

"lua {{{
"}}}

"ruby {{{
"}}}

"python {{{
"}}}

"php {{{
"}}}

"js {{{
"}}}

"nginx {{{
au BufRead,BufNewFile nginx.conf set ft=nginx
au BufRead,BufNewFile nginx.conf.* set ft=nginx
au BufRead,BufNewFile nginx.*.conf set ft=nginx
"}}}

"Docker {{{
au BufRead,BufNewFile Dockerfile set ft=dockerfile
"}}}

"syntax check{{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'gofmt', 'golint', 'errcheck', 'govet']
"let g:syntastic_go_checkers = ['gofmt', 'golint', 'errcheck', 'govet']

let g:syntastic_lua_checkers = ["luac", "luacheck"]
let g:syntastic_lua_luacheck_args = "--no-unused-args"

let g:syntastic_ruby_mri_exec = '~/.rbenv/shims/ruby'
"}}}

"vimfiler {{{
"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0
"open it like IDE
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)
"autocmd VimEnter * VimFilerExplorer

" remap q to hide and close buffer
autocmd FileType vimfiler nmap <buffer> q <Plug>(vimfiler_exit)
"}}}

"Unite {{{
" start with insert mode
"let g:unite_enable_start_insert=1
" enable yank history
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit = 100

" Unite source list
nnoremap <silent> <Leader>us :<C-u>Unite source<CR>
" bookmark list
"nnoremap <silent> <Leader>>ubk :<C-u>Unite bookmark<CR>
" buffer list
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
" file list
nnoremap <silent> <Leader>uff :<C-u>Unite file<CR>
" recursive file list
nnoremap <silent> <Leader>uf :<C-u>Unite file_rec/async<CR>
" register list
"nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<CR>
" file recently used
nnoremap <silent> <Leader>uh :<C-u>Unite file_mru<CR>
" combine mostly used one
nnoremap <silent> <Leader>uu :<C-u>Unite buffer file_mru<CR>
" content search (= grep)
nnoremap <silent> <Leader>u/ :<C-u>Unite grep:<CR>
" yank history list
nnoremap <silent> <Leader>uy :<C-u>Unite history/yank<CR>
" show code outlines
nnoremap <silent> <Leader>uo :<C-u>Unite outline<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
"}}}
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
"}}}

"nerdcommenter {{{

"}}}
