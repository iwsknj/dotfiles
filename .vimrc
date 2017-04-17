"""""""""""""""""""""""""""""""""""""""""
" neobundle
"""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

set nocompatible
if has('vim_starting')
	 set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))
	NeoBundleFetch 'Shougo/neobundle.vim'

	""""""""""""""""""""""""""""""""""""
	" vim plugins
	""""""""""""""""""""""""""""""""""""
	
	" コードを自動的に入力補完してくれる
	NeoBundle 'Shougo/neocomplete'
	
	" スニペット
	NeoBundle 'Shougo/neosnippet'
	NeoBundle 'Shougo/neosnippet-snippets'

	" ファイルをtree表示してくれる
	NeoBundle 'scrooloose/nerdtree'

	" コメントON/OFFを手軽に実行
	NeoBundle 'tomtom/tcomment_vim'

	" シングルクオートとダブルクオートの入れ替え等
	NeoBundle 'tpope/vim-surround'

	" インデントに色を付けて見やすくする
	"NeoBundle 'nathanaelkane/vim-indent-guides'
	"let g:indent_guides_enable_on_vim_startup = 1

	" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
	let g:indent_guides_enable_on_vim_startup = 1

	" ログファイルを色づけしてくれる
	NeoBundle 'vim-scripts/AnsiEsc.vim'

	" 行末の半角スペースを可視化
	NeoBundle 'bronson/vim-trailing-whitespace'
	
	" 下のステータスラインを見やすくする(設定は下に)
	NeoBundle 'itchyny/lightline.vim'

	" HTML5のタグに色を付ける
	NeoBundle 'taichouchou2/html5.vim'
	
	" JSのタグに色を付ける
	NeoBundle 'taichouchou2/vim-javascript'
	
	" CSS3のタグに色を付ける
	NeoBundle 'hail2u/vim-css3-syntax'
	
	" Sass
	"NeoBundle 'AtsushiM/search-parent.vim'
	"NeoBundle 'AtsushiM/sass-compile.vim'

	" Emmet
	NeoBundle 'mattn/emmet-vim'
	
	" カラースキーマ molokai
	NeoBundle 'tomasr/molokai' 
	
	

	""""""""""""""""""""""""""""""""""""

call neobundle#end()

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample

""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
	augroup InsertHook
		autocmd!
		autocmd InsertEnter * call s:StatusLine('Enter')
		autocmd InsertLeave * call s:StatusLine('Leave')
	augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
	if a:mode == 'Enter'
		silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
		silent exec g:hi_insert
	else
		highlight clear StatusLine
		silent exec s:slhlcmd
	endif
endfunction

function! s:GetHighlight(hi)
	redir => hl
	exec 'highlight '.a:hi
	redir END
	let hl = substitute(hl, '[\r\n]', '', 'g')
	let hl = substitute(hl, 'xxx', '', '')
	return hl
endfunction
"""""""""""""""""""""""""""""""""""""""""""


" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" setting
""""""""""""""""""""""""""""""
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" ファイルが外部で変更された際に自動で読み込む
set autoread

" カラースキーマ
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
syntax on
colorscheme molokai
set term=xterm-256color
set t_Co=256
highlight LineNr ctermfg=yellow

" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする

" 行を折り返さない
set nowrap
" ターミナルのタイトルをセットする
set title
" 対応するカッコを強調表示する
set showmatch
" タブを以下の文字で表示する
"set list listchars=tab:\▸\-
" バックスペースを、空白、行末、行頭でも使えるようにする
set backspace=indent,eol,start
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
" 改行時に自動でインデントを行なう
set autoindent
" マウスを有効にする
set mouse=a
" OSとクリップボードを共有する
set clipboard=unnamed,autoselect
" 未保存ファイルの終了時に保存確認を行なう
set confirm

"検索設定
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索結果をハイライト表示する
set hlsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan


""""""""""""""""""""""""""""""
" Keymap
""""""""""""""""""""""""""""""
noremap j gj
noremap k gk



""""""""""""""""""""""""""""""
" plugin setting
""""""""""""""""""""""""""""""

"light line

let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ }

""""""""""""""""""""""""""""""""""""""""""""
