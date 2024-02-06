" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required)
let s:dein_base = '/Users/takahiro-tachiki/.cache/dein'

" Set Dein source path (required)
let s:dein_src = '/Users/takahiro-tachiki/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
call dein#add('mattn/vdbi-vim')
call dein#add('mattn/webapi-vim')
call dein#add('mattn/emmet-vim')
call dein#add('fholgado/minibufexpl.vim')
call dein#add('pangloss/vim-javascript')
call dein#add('scrooloose/syntastic')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets.vim')
call dein#add('h1mesuke/unite-outline')
call dein#add('vim-scripts/Align')
call dein#add('bling/vim-airline')
call dein#add('scrooloose/nerdtree.git')
call dein#add('thinca/vim-quickrun.git')
call dein#add('Shougo/neocomplcache.git')
call dein#add('Rip-Rip/clang_complete.git')
call dein#add('ftdetect/ruby.vim')
"  call dein#add('indent/ruby.vim')
call dein#add('tpope/vim-rails')



" Finish Dein initialization (required)
call dein#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax enable

" Uncomment if you want to install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif
"
" Align
set nocp
filetype plugin indent on

" for message about file ctf+g 
set shortmess+=I
" setting for command line
set cmdheight=2
" display title
set title
" cursol max/min available
set scrolloff=2
 
" key map
" move at line
" for nomalmode mapping
nnoremap j gj
nnoremap k gk

" for inputmode mapping
" <Leader> → \
" ex) type \date
inoremap <Leader>date <C-R>=strftime('%A, %B %d, %Y')<CR>
inoremap <Leader>time <C-R>=strftime('%H:%M')<CR>
inoremap <Leader>rdate <C-R>=strftime('%A, %B %d, %Y %H:%M')<CR>
inoremap <Leader>w3cdtf <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>

" 選択したものを*で検索
vnoremap * "zy:let @/ = @z<CR>n

" putline_twの変数を60にして、line文字列をマッピング
"-----------------------------------------------------------
let putline_tw = 60
inoremap <Leader>line <ESC>:call <SID>PutLine(putline_tw)<CR>A
function! s:PutLine(len)
  let plen = a:len - strlen(getline('.'))
  if (plen > 0)
    execute 'normal ' plen . 'A-'
  endif
endfunction

" backup setting
set backup
set backupdir=$HOME/.backup

set swapfile
set directory=$HOME/.backup

" utf-8
"-----------------------------------------------------------
" http://d.hatena.ne.jp/ka-nacht/20080220/1203433500
" for use output encoding for terminal
set termencoding=utf-8
" for use vim internal encoding
set encoding=utf-8
" for use writing buffer file
set fileencoding=utf-8
set fileencodings=utf-8,euc-jisx0213,euc-jp,cp932
if &encoding == 'utf-8'
  set ambiwidth=double
endif

" 先頭が0でも8進数として扱わない
" http://www15.ocn.ne.jp/~tusr/vim/vim_text2.html#mozTocId784085
set nrformats-=octal

" autodate
"-----------------------------------------------------------
let g:autodate_format = '%Y-%m-%d'
let g:autodate_keyword_pre = 'Last Modified:'
let g:autodate_keyword_post = '$'

"辞書ファイルを使用する設定に変更
set complete+=k
"-----------------------------------------------------------------------------
" 検索関連
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
"タブをインデントにする
"set smarttab
"タブ入力を空白文字で置き換え
set expandtab
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
set autoindent

" メッセージを日本語にする
let $LANG = 'japanese'

" for minibufexpl.vim
:let g:miniBufExplMapWindowNavVim = 1
:let g:miniBufExplMapWindowNavArrows = 1
:let g:miniBufExplMapCTabSwitchBuffs = 1

filetype on

augroup SkeletonAu
    autocmd!
    autocmd BufNewFile *.sh 0r $HOME/.vim/templates/skel.sh
    autocmd BufNewFile *.html 0r $HOME/.vim/templates/skel.htm
    autocmd BufNewFile *.php 0r $HOME/.vim/templates/skel.php
    autocmd BufNewFile *.rb 0r $HOME/.vim/templates/skel.rb

    "php 保管
    " ファイルタイプごとに辞書ファイルを指定
    autocmd FileType php :set dictionary=~/.vim/dict/php.dict
    " makeコマンドでシンタックスチェック
    autocmd Filetype php :set makeprg=php\ -l\ %
    autocmd Filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l

    " vim7
    " autocmd FileType py set omnifunc=pythoncomplete#Complete
    " autocmd FileType js set omnifunc=javascriptcomplete#CompleteJS
    " autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    " autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    " autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    " autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    " autocmd FileType c set omnifunc=ccomplete#Complete

    " syntax check for perl
    autocmd FileType perl :map <silent><C-c> :cn<CR>
    autocmd FileType perl :map <silent><C-l> :cl<CR>
    autocmd FileType perl :nnoremap <buffer> <silent> X :w<CR>:!perl -c -MVi::QuickFix % <CR>
    autocmd FileType perl :nnoremap <buffer> <silent> E :cf <CR>

    autocmd FileType php        setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType javascript setlocal expandtab   shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType ruby       setlocal expandtab   shiftwidth=2 tabstop=2 softtabstop=2
augroup END


" scroll
noremap <Space>j <C-f>
noremap <Space>k <C-b>

" javascript syntax
"setlocal conceallevel=2
syntax keyword javaScriptLambda function conceal cchar=λ
highlight clear Conceal
highlight link Conceal Identifier
highlight link javaScriptLambda Identifier

" 全角の表示
highlight ZenkakuSpace term=underline ctermbg=lightblue guibg=darkgray
match ZenkakuSpace /　/
augroup highlightIdegraphicSpace                                                                                                                      
    autocmd! highlightIdegraphicSpace                                                                                                                 
    autocmd Colorscheme * highlight ZenkakuSpace term=underline ctermbg=lightblue guibg=darkgray                                                      
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/                                                                                              
augroup END    

set t_Co=256
let g:rehash256=1
syntax on

" syntastic
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': [], 
  \ 'passive_filetypes': ['html', 'javascript'] }
let g:syntastic_auto_loc_list = 1 
let g:syntastic_javascript_checker = 'gjslint'

" airlineなどを優先する
let g:unite_force_overwrite_statusline = 0

" vim airline
let g:airline#extensions#branch = 0
let g:airline_section_b = "%t %M"
let g:airline_section_c = ''
let s:sep = " %{get(g:, 'airline_right_alt_sep', '')} "
let g:airline_section_x =
      \ "%{strlen(&fileformat)?&fileformat:''}".s:sep.
      \ "%{strlen(&fenc)?&fenc:&enc}".s:sep.
      \ "%{strlen(&filetype)?&filetype:'no ft'}"
let g:airline_section_y = '%3p%%'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
let g:airline#extensions#whitespace#enabled = 0


" neocomplecacheを反映する
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
      \  'default' : '',
      \  'vimshell' : $HOME.'/.vimshell_hist',
      \  'scheme' : $HOME.'/.gosh_completions'
      \}

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" nerdtree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" livedown
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 0
" should the browser window pop-up upon previewing
let g:livedown_open = 1 
" the port on which Livedown server will run
let g:livedown_port = 1337
map gm :call LivedownPreview()<CR>

" for emmet vim
let g:user_emmet_leader_key='<c-r>'

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
