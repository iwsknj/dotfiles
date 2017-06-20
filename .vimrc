"""""""""""""""""""""""""""""""""""""""""""
"dein(プラグイン管理)コード"
"""""""""""""""""""""""""""""""""""""""""""
"dein Scripts-----------------------------

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'


if &compatible
  set nocompatible               " Be iMproved
endif

if !isdirectory(s:dein_repo_dir)
  execute '!git clone git@github.com:Shougo/dein.vim.git' s:dein_repo_dir
endif


" Required:
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
"set runtimepath+=~/dotfiles/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(expand('~/.vim/dein'))
  call dein#begin(s:dein_dir)

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_repo_dir)

  	"tomlファイルを使用---------------------------------------------
	" プラグインリストを収めた TOML ファイル
	" 予め TOML ファイル（後述）を用意しておく
	let s:toml_dir  = '~/dotfiles/dein'
	let s:toml      = s:toml_dir . '/dein.toml'
	let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'

	" TOML を読み込み、キャッシュしておく
	call dein#load_toml(s:toml,      {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})
	"---------------------------------------------------------------

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

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

"""""""""""""""""""""""""""""""""""""""""""
"End dein Scripts
"""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
"プラグイン設定
""""""""""""""""""""""""""""""""""""""""""""
	"====NERDtree====
	nnoremap <silent><C-e> :NERDTreeToggle<CR>

	"ファイル指定で開かれた場合はNERDTreeを表示しない
	if !argc()
		autocmd vimenter * NERDTree|normal gg3j
	endif

	"====Unite====

	"常にインサートモードで起動
	let g:unite_enable_start_insert = 1

	"escを2回押すとUniteを閉じる
	au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
	au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

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
set encoding=utf-8
set fenc=utf-8
"set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
"set fileformats=unix,dos,mac

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

" 背景色をターミナルと同じにする
autocmd ColorScheme * highlight Normal ctermbg=none

" 行のラインの背景色をターミナルと同じにする
autocmd ColorScheme * highlight LineNr ctermbg=none

" カラースキーマのシンタックスを有効にする
syntax on
set term=xterm-256color

" vimで使える色を256色にする
set t_Co=256

" カラースキーマ
"colorscheme monokai
"colorscheme solarized
colorscheme molokai
"colorscheme jellybeans
"colorscheme hybrid
"colorscheme gruvbox

" カーソルの行の数字の色
highlight LineNr ctermfg=215
" カーソルの行の数字のハイライトの色
highlight CursorLineNr ctermfg=yellow

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
"noremap => ノーマルモード+ビジュアルモード
"noremap! => コマンドラインモード+インサートモード
"nnoremap => ノーマルモード
"vnoremap => ビジュアル（選択）モード
"cnoremap => コマンドラインモード
"inoremap => インサートモード




"日本語入力がオンのままでも使えるコマンド(Enterキーは必要)
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap っｄ dd
nnoremap っｙ yy


"表示行単位での上下移動
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

"一画面分の移動
nnoremap <S-k> <C-b>
nnoremap <S-j> <C-f>

"行の端への移動
nnoremap <C-h> 0
nnoremap <S-h> ^
nnoremap <S-l> $

"カッコ補完
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>}

""""""""""""""""""""""""""""""
" plugin setting
""""""""""""""""""""""""""""""

"light line

let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ }

""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
"""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""
