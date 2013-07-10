set nocompatible
" ---- vundle ---- "
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()
Bundle 'autocomp.vim'
"Bundle 'Align.vim'
Bundle 'cecutil'
Bundle 'matrix.vim'
Bundle 'minibufexpl.vim'
Bundle 'minibufexplorerpp'
Bundle 'php-doc'
Bundle 'PHP-dictionary'
Bundle 'writebackup'
Bundle 'YankRing.vim'
Bundle 'SuperTab'
Bundle 'textmanip.vim'
Bundle 'vimwiki'
Bundle 'confluencewiki.vim'
Bundle 'ZenCoding.vim'
Bundle 'ref.vim'
Bundle 'php_funcinfo.vim'
Bundle 'quickhl.vim'
"Bundle 'jslint.vim'
filetype plugin indent on
" ---- /vundle ---- "



" display
"-----------------------------------------------------------
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  hi! Comment     term=standout ctermfg=Magenta     cterm=none
  hi! ErrorMsg    term=standout ctermfg=White   cterm=none
  hi! Error       term=standout ctermfg=White   cterm=none
  hi! WarningMsg  term=standout ctermfg=White   cterm=none
  hi! Search      term=standout ctermfg=RED   ctermbg=none   cterm=underline
  hi! Statement                 ctermfg=Cyan   cterm=none
  hi! PreProc                   ctermfg=Cyan    cterm=none
  hi! Special                   ctermfg=Cyan    cterm=none
  hi! Type                      ctermfg=Green   cterm=none
  hi! Constant                  ctermfg=Cyan    cterm=none
  hi! Identifier                ctermfg=Green   cterm=none
  hi! LineNr      term=standout ctermfg=white    cterm=underline
  " html ハイライト定義
  hi! htmlTitle ctermfg=Green   ctermfg=none
  hi! htmlLink  ctermfg=Green
  hi! htmlH1    ctermfg=Green
  hi! htmlH2    ctermfg=Green
  hi! htmlH3    ctermfg=Green
  hi! htmlH4    ctermfg=Green
  hi! htmlH5    ctermfg=Green
  hi! htmlH6    ctermfg=Green
  set hlsearch
endif

" for message about file ctr+g
set shortmess+=I
" setting for command line
set cmdheight=2
" display title
set title
" cursol max/min available
set scrolloff=2

hi StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=Darkblue
set statusline=%<%f\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v\ %l/%L
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" key map
" move at line
" for normalmode
nnoremap j gj
nnoremap k gk

" for inputmode
inoremap <Leader>date <C-R>=strftime('%A, %B %d, %Y')<CR>
inoremap <Leader>time <C-R>=strftime('%H:%M')<CR>
inoremap <Leader>rdate <C-R>=strftime('%A, %B %d, %Y %H:%M')<CR>
inoremap <Leader>w3cdtf <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>

" for visual mode
vnoremap * "zy:let @/ = @z<CR>n

" putline
"-----------------------------------------------------------
let putline_tw = 60

inoremap <Leader>line <ESC>:call <SID>PutLine(putline_tw)<CR>A
function! s:PutLine(len)
  let plen = a:len - strlen(getline('.'))
  if (plen > 0)
    execute 'normal ' plen . 'A-'
  endif
endfunction

" utf-8
"-----------------------------------------------------------
"let &termencoding=&encoding
" http://d.hatena.ne.jp/ka-nacht/20080220/1203433500
" use output encoding for terminal
set termencoding=utf-8
" for use vim internal encoding
set encoding=utf-8
" for use writing buffer file
set fileencoding=utf-8
" for use global option
"set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp-2,euc-jisx0213,euc-jp,cp932,utf-8
set fileencodings=utf-8,euc-jisx0213,euc-jp,cp932

if &encoding == 'utf-8'
  set ambiwidth=double
endif

" format.vim
"-----------------------------------------------------------
let format_allow_over_tw = 0

" chalice
"-----------------------------------------------------------
set runtimepath+=$HOME/.vim/chalice
nnoremap <F2> :call <SID>DoChalice()<CR>
let chalice_preview = 0
let chalice_columns = 120
let chalice_exbrowser = 'openurl %URL% &'
function! s:DoChalice()
  Chalice
endfunction

" autodate
"-----------------------------------------------------------
let g:autodate_format = '%Y-%m-%d'
let g:autodate_keyword_pre = 'Last Modified:'
let g:autodate_keyword_post = '$'

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

endif " has("autocmd")


"php 保管
" ファイルタイプごとに辞書ファイルを指定
autocmd FileType php  :set dictionary=~/.vim/dict/php.dict

"php doc 用
"source $HOME/.vim/plugin/php-doc.vim
inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-D> :call PhpDocSingle()<CR>
vnoremap <C-D> :call PhpDocRange()<CR>

"辞書ファイルを使用する設定に変更
set complete+=k
"-----------------------------------------------------------------------------
" 検索関連
"
"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
set incsearch
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"検索時に最後まで行ったら最初に戻る
set wrapscan
"検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch
"行番号を表示する
set number
"タブ幅を設定する
set tabstop=8
"set shiftwidth=2
"set softtabstop=4
set smarttab
"入力中のコマンドをステータスに表示する
set showcmd
"括弧入力時の対応する括弧を表示
set showmatch
"検索結果文字列のハイライトを有効にする
set hlsearch
"ステータスラインを常に表示
set laststatus=2
"バックスペースを有効にする
set backspace=indent,eol,start
set wildmenu
set formatoptions+=mM
"バックアップファイルの作成
"set backupdir=z:\\backup
"タブ入力を空白文字で置き換え
"set expandtab
set autoindent
"バーの色の調整
"hi DiffAdd ctermfg=g ctermbg=green

" for minibufexpl.vim
:let g:miniBufExplMapWindowNavVim = 1
:let g:miniBufExplMapWindowNavArrows = 1
:let g:miniBufExplMapCTabSwitchBuffs = 1

:abbr #b /***********************************************
:abbr #e ***********************************************/

augroup SkeletonAu
    autocmd!
    autocmd BufNewFile *.html 0r $HOME/.vim/templates/skel.html
    autocmd BufNewFile *.php 0r $HOME/.vim/templates/skel.php
augroup END

" @2011/1/5
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><C-x><<C-f>  neocomplcache#manual_filename_complete()

" vim7
autocmd FileType py set omnifunc=pythoncomplete#Complete
autocmd FileType js set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Align
set nocp
filetype plugin on

" scroll
noremap <Space>j <C-f>
noremap <Space>k <C-b>

"===========================================
"vim-textmanip
" 選択したテキストの移動
vmap <C-j> <Plug>(Textmanip.move_selection_down)
vmap <C-k> <Plug>(Textmanip.move_selection_up)
vmap <C-h> <Plug>(Textmanip.move_selection_left)
vmap <C-l> <Plug>(Textmanip.move_selection_right)

" 行の複製
vmap <M-d> <Plug>(Textmanip.duplicate_selection_v)
nmap <M-d> <Plug>(Textmanip.duplicate_selection_n)
"===========================================
" zencoding
let g:user_zen_expandabbr_key = '<c-e>'  

" javascript
au FileType javascript set ts=4 sw=4 expandtab
au BufNewFile *.js set ft=javascript fenc=utf-8
syntax keyword javaScriptLambda function conceal cchar=
highlight clear Conceal
highlight link Conceal Identifier
highlight link javaScriptLambda Identifier

"map <F5> <Esc> :!php % <Return>

" quichhhl
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)

autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/

" syntax check for perl
autocmd filetype perl :map <silent><C-c> :cn<CR>
autocmd filetype perl :map <silent><C-l> :cl<CR>
autocmd filetype perl :nnoremap <buffer> <silent> X :w<CR>:!perl -c -MVi::QuickFix %<CR>
autocmd filetype perl :nnoremap <buffer> <silent> E :cf <CR>

