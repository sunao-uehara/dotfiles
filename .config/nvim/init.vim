set encoding=utf-8
set history=700

syntax enable
colorscheme molokai
let g:rehash256 = 1
let g:molokai_original = 1

set number
set ruler
set hlsearch
set incsearch

set ts=2 sw=2 sts=2
set expandtab

set ai
set si

set guioptions-=M "menubar
set guioptions-=T "toolbar
set guioptions-=r "scrollbar

set nocompatible

"dein{{{
" Vim起動完了時にインストール
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
  call dein#add('zchee/deoplete-go')
  "call dein#add('scrooloose/syntastic') " too slow when saving, disable it for now
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('airblade/vim-gitgutter')

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

  " 依存関係がある場合
  call dein#add('Shougo/unite.vim')
  call dein#add('ujihisa/unite-colorscheme', {'depends' : 'Shougo/unite.vim'})
  call dein#add('Shougo/vimfiler.vim', {'depends' : 'Shougo/unite.vim'})

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

"deoplete{{{
let g:deoplete#enable_at_startup = 1
" To make deoplete work properly, st python bin explicitly
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
"}}}

"golang {{{
set path+=$GOPATH/src/**
let g:gofmt_command = 'goimports'
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

" auto complete
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
"}}}

"syntax check{{{
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['go'] }
"let g:syntastic_go_checkers = ['go', 'golint']
"let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
"let g:syntastic_go_checkers = ['golint']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"}}}

"vimfiler {{{
"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0
"現在開いているバッファのディレクトリを開く
"nnoremap <silent> <space>fe :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <silent> <space>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)
"autocmd VimEnter * VimFilerExplorer
"}}}

"Unite {{{
" start with insert mode
"let g:unite_enable_start_insert=1
" enable yank history
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit = 100

" Unite source list
nnoremap <silent> <space>u :<C-u>Unite source<CR>
" bookmark list
nnoremap <silent> <space>ubk :<C-u>Unite bookmark<CR>
" buffer list
nnoremap <silent> <space>ub :<C-u>Unite buffer<CR>
" file list
nnoremap <silent> <space>uf :<C-u>Unite file_rec/async<CR>
" register list
"nnoremap <silent> <space>ur :<C-u>Unite -buffer-name=register register<CR>
" file recently used
nnoremap <silent> <space>uh :<C-u>Unite file_mru<CR>
" combine mostly used one
nnoremap <silent> <space>uu :<C-u>Unite buffer file_mru<CR>
" content search (= grep)
nnoremap <silent> <space>u/ :<C-u>Unite grep:<CR>
" yank history list
nnoremap <silent> <space>uy :<C-u>Unite history/yank<CR>
" show code outlines
nnoremap <silent> <space>uo :<C-u>Unite outline<CR>
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
