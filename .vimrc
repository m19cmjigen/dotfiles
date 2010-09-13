set nocompatible

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

set shortmess+=I

"set list
"set listchars=tab:>-,trail:-,extends:>,precedes:<
"set display=uhex

set cmdheight=2
set title

set scrolloff=2

set statusline=%<%f\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v\ %l/%L
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" key map
" move at line
nnoremap j gj
nnoremap k gk

" input time
inoremap <Leader>date <C-R>=strftime('%A, %B %d, %Y')<CR>
inoremap <Leader>time <C-R>=strftime('%H:%M')<CR>
inoremap <Leader>rdate <C-R>=strftime('%A, %B %d, %Y %H:%M')<CR>
inoremap <Leader>w3cdtf <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>

" search
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
set termencoding=utf-8
set encoding=utf-8
"set fileencoding=utf-8
set fileencoding=japan
"set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp-2,euc-jisx0213,euc-jp,cp932,utf-8
"set fileencodings=iso-2022-jp,utf-8,euc-jp,ucs-2le,ucs-2,cp932 
set fileencodings=utf-8,ist-2022-jp,euc-jp,ucs-2le,ucs-2,cp932 

if &encoding == 'utf-8'
  set ambiwidth=double
endif
" 新しく作成した時はUTF-8にセットする。
autocmd BufNewFile *.{py,php,txt,css,htm*}{,.in} set fileencoding=utf-8


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
"
" ファイルタイプごとに辞書ファイルを指定
autocmd FileType php :set dictionary+=$HOME/.vim/php.dict
"辞書ファイルを使用する設定に変更
set complete+=k

" phpdoc 用のコメントを追加するキーバインド
source $HOME/.vim/plugin/php-doc.vim
inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-D> :call PhpDocSingle()<CR>
vnoremap <C-D> :call PhpDocRange()<CR> 

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
set tabstop=4
set shiftwidth=4
set softtabstop=4
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
"set backupdir=z:¥¥backup
"タブ入力を空白文字で置き換え
"set expandtab
set autoindent
"バーの色の調整
"hi DiffAdd ctermfg=g ctermbg=green

" メッセージを日本語にする
let $LANG = 'japanese'


" Alignを日本語環境でしようする
let g:Align_xstrlen = 3

inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>" : "\<CR>"


" htmlの為の設定
augroup SkeletonAu
    autocmd!
    autocmd BufNewFile *.html 0r $HOME/.vim/templates/skel.html
augroup END
