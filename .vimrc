set nocompatible
" ---- vundle ---- "
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()
Bundle 'autocomp.vim'
"Bundle 'Align.vim'
Bundle 'cecutil'
Bundle 'javaScriptLint.vim'
Bundle 'matrix.vim'
Bundle 'minibufexpl.vim'
Bundle 'minibufexplorerpp'
Bundle 'php-doc'
Bundle 'PHP-dictionary'
Bundle 'writebackup'
Bundle 'YankRing.vim'
Bundle 'SuperTab'
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
  " html �ϥ��饤�����
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

hi StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=Darkblue
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
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp-2,euc-jisx0213,euc-jp,cp932,utf-8

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


"php �ݴ�
" �ե����륿���פ��Ȥ˼���ե���������
autocmd FileType php  :set dictionary=~/.vim/dict/php.dict

"php doc ��
"source $HOME/.vim/plugin/php-doc.vim
inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-D> :call PhpDocSingle()<CR>
vnoremap <C-D> :call PhpDocRange()<CR>


"����ե��������Ѥ���������ѹ�
set complete+=k
"-----------------------------------------------------------------------------
" ������Ϣ
"
"����ʸ���󤬾�ʸ���ξ�����ʸ����ʸ������̤ʤ���������
set ignorecase
set incsearch
"����ʸ�������ʸ�����ޤޤ�Ƥ�����϶��̤��Ƹ�������
set smartcase
"�������˺Ǹ�ޤǹԤä���ǽ�����
set wrapscan
"����ʸ�������ϻ��˽缡�о�ʸ����˥ҥåȤ����ʤ�
set noincsearch

"���ֹ��ɽ������
set number
"�����������ꤹ��
set tabstop=8
"set shiftwidth=2
"set softtabstop=4
set smarttab
"������Υ��ޥ�ɤ򥹥ơ�������ɽ������
set showcmd
"������ϻ����б������̤�ɽ��
set showmatch
"�������ʸ����Υϥ��饤�Ȥ�ͭ���ˤ���
set hlsearch
"���ơ������饤�����ɽ��
set laststatus=2
"�Хå����ڡ�����ͭ���ˤ���
set backspace=indent,eol,start
set wildmenu
set formatoptions+=mM
"�Хå����åץե�����κ���
"set backupdir=z:\\backup
"�������Ϥ����ʸ�����֤�����
"set expandtab
set autoindent
"�С��ο���Ĵ��
"hi DiffAdd ctermfg=g ctermbg=green

" ���ܸ�򰷤������ɬ��
"set encoding=japan
" �ե�����δ��������ɼ�ưȽ�̤Τ����ɬ�ס�(��iconv)
"if has('yiconv++')
" set fileencodings+=iso-2022-jp
" set fileencodings+=utf-8,ucs-2le,ucs-2
" if &encoding ==# 'euc-jp'
" set fileencodings+=cp932
" else
" set fileencodings+=euc-jp
" endif
"endif
" ��å����������ܸ�ˤ���
let $LANG = 'japanese'

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

"call pathogen#runtime_append_all_bundles()
