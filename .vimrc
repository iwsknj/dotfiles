"""""""""""""""""""""""""""""""""""""""""""
"dein(プラグイン管理)コード"
"""""""""""""""""""""""""""""""""""""""""""
"dein Scripts-----------------------------

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'


if &compatible
	set nocompatible				 " Be iMproved
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
	let s:toml_dir	= '~/dotfiles/dein'
	let s:toml		= s:toml_dir . '/dein.toml'
	let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'

	" TOML を読み込み、キャッシュしておく
	call dein#load_toml(s:toml,		 {'lazy': 0})
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
	"====neocomplete====
		" 補完ウィンドウの設定
		set completeopt=menuone

		" Disable AutoComplPop.
		let g:acp_enableAtStartup = 0
		" Use neocomplete.
		let g:neocomplete#enable_at_startup = 1
		" Use smartcase.
		let g:neocomplete#enable_smart_case = 1
		" Set minimum syntax keyword length.
		let g:neocomplete#sources#syntax#min_keyword_length = 3

		" Define dictionary.
		let g:neocomplete#sources#dictionary#dictionaries = {
		    \ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

		" Define keyword.
		if !exists('g:neocomplete#keyword_patterns')
		    let g:neocomplete#keyword_patterns = {}
		endif
		let g:neocomplete#keyword_patterns['default'] = '\h\w*'

		" Plugin key-mappings.
		inoremap <expr><C-g>     neocomplete#undo_completion()
		inoremap <expr><C-l>     neocomplete#complete_common_string()

		" Recommended key-mappings.
		" <CR>: close popup and save indent.
		inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
		function! s:my_cr_function()
			return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
			" For no inserting <CR> key.
			"return pumvisible() ? "\<C-y>" : "\<CR>"
		endfunction
		" <TAB>: completion.
		inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
		" <C-h>, <BS>: close popup and delete backword char.
		inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
		inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
		" Close popup by <Space>.
		"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

		" AutoComplPop like behavior.
		"let g:neocomplete#enable_auto_select = 1

		" Shell like behavior(not recommended).
		"set completeopt+=longest
		"let g:neocomplete#enable_auto_select = 1
		"let g:neocomplete#disable_auto_complete = 1
		"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

		" Enable omni completion.
		autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
		autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
		autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
		autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
		autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

		" Enable heavy omni completion.
		if !exists('g:neocomplete#sources#omni#input_patterns')
			let g:neocomplete#sources#omni#input_patterns = {}
		endif
		"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
		"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
		"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

		" For perlomni.vim setting.
		" https://github.com/c9s/perlomni.vim
		let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


	"====neosnippet=====
		" Plugin key-mappings.
		imap <C-k>     <Plug>(neosnippet_expand_or_jump)
		smap <C-k>     <Plug>(neosnippet_expand_or_jump)
		xmap <C-k>     <Plug>(neosnippet_expand_target)

		" SuperTab like snippets behavior.
		" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
		imap <C-k>     <Plug>(neosnippet_expand_or_jump)
		"imap <expr><TAB>
		" \ pumvisible() ? "\<C-n>" :
		" \ neosnippet#expandable_or_jumpable() ?
		" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
		smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
		\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

		" For conceal markers.
		if has('conceal')
		  set conceallevel=2 concealcursor=niv
		endif

	"====NERDtree====
		nnoremap <silent><C-e> :NERDTreeToggle<CR>

		"ファイル指定で開かれた場合はNERDTreeを表示しない
		if !argc()
			autocmd vimenter * NERDTree|normal gg3j
		endif

	"====Unite====
		" key map
		nmap	<Space>u [unite]

		"<space>uf => ファイル一覧を表示
		nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>
		"<space>ufn => ファイル作成
		nnoremap <silent> [unite]fn :<C-u>Unite<Space>file/new<CR>
		"<space>ua => カレントディレクトリを表示
		nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
		"<space>ud => 最近開いたディレクトリを表示
		nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
		"<space>ub => バッファを表示
		nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
		"<space>ur => レジストリを表示
		nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
		"<space>ut => タブを表示
		nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
		"<space>ubo => ブックマークを表示
		nnoremap <silent> [unite]bo :<C-u>Unite<Space>bookmark<CR>
		"<space>uboa => ブックマークに追加
		nnoremap <silent> [unite]boa :<C-u>UniteBookmarkAdd<CR>
		"<space>uh => ヒストリー/ヤンクを表示
		nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
		"<space>ug => grep検索
		nnoremap <silent> [unite]g	 :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
		"<space>ugd => grep検索（ディレクトリ指定)
		nnoremap <silent> [unite]gd  :<C-u>Unite grep -buffer-name=search-buffer<CR>


		" unite grepにhw(highway)を使う
		if executable('hw')
			let g:unite_source_grep_command = 'hw'
			let g:unite_source_grep_default_opts = '--no-group --no-color'
			let g:unite_source_grep_recursive_opt = ''
		endif

		" Unite内での入力文字列の置換
			"file
			call unite#custom#substitute('file', '[^~.]\zs/', '*/*')
			call unite#custom#substitute('file', '/\ze[^*]', '/*')


		"常にインサートモードで起動
		let g:unite_enable_start_insert = 1
		"大文字小文字を区別しない
		let g:unite_enable_ignore_case = 1
		let g:unite_enable_smart_case = 1
		"ヒストリー/ヤンク機能を有効化
		let g:unite_source_history_yank_enable =1

		"escを2回押すとUniteを閉じる
		au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
		au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

		"====Emmet=====
			let g:user_emmet_leader_key='<c-t>'

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
" 行末のスペース削除
""""""""""""""""""""""""""""""
autocmd BufWritePre * :%s/\s\+$//ge
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" setting
""""""""""""""""""""""""""""""
"文字コードをUFT-8に設定
set encoding=utf-8
set fenc=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
set ambiwidth=double

set nobackup " バックアップファイルを作らない
set noswapfile " スワップファイルを作らない
set autoread " 編集中のファイルが変更されたら自動で読み直す
set hidden " バッファが編集中でもその他のファイルを開けるように
set showcmd " 入力中のコマンドをステータスに表示する
set autoread " ファイルが外部で変更された際に自動で読み込む

set number " 行番号を表示
set cursorline " 現在の行を強調表示
"set cursorcolumn " 現在の行を強調表示（縦）
set virtualedit=onemore " 行末の1文字先までカーソルを移動できるように
set smartindent " インデントはスマートインデント
set visualbell " ビープ音を可視化
set showmatch " 括弧入力時の対応する括弧を表示
set laststatus=2 " ステータスラインを常に表示
set wildmode=list:longest " コマンドラインの補完
set wrap " 行を折り返さない
set title " ターミナルのタイトルをセットする
set showmatch " 対応するカッコを強調表示する
"set list listchars=tab:\▸\- " タブを以下の文字で表示する
hi SpecialKey ctermfg=darkmagenta
set list listchars=tab:\¦\_  "タブの表示
set backspace=indent,eol,start " バックスペースを、空白、行末、行頭でも使えるようにする
set tabstop=4 " 行頭以外のTab文字の表示幅（スペースいくつ分）
set shiftwidth=4 " 行頭でのTab文字の表示幅
set autoindent " 改行時に自動でインデントを行なう
set mouse=a " マウスを有効にする
set clipboard=unnamed,autoselect " OSとクリップボードを共有する
set confirm " 未保存ファイルの終了時に保存確認を行なう

"検索設定
set ignorecase " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase " 検索文字列に大文字が含まれている場合は区別して検索する
set hlsearch " 検索結果をハイライト表示する
set wrapscan " 検索時に最後まで行ったら最初に戻る
" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>"

""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" カラー
""""""""""""""""""""""""""""""

" カラースキーマ
"colorscheme monokai
"colorscheme solarized
colorscheme molokai
"colorscheme jellybeans
"colorscheme hybrid
"colorscheme gruvbox

" 背景色をターミナルと同じにする
autocmd ColorScheme * highlight Normal ctermbg=none
" 行のラインの背景色をターミナルと同じにする
autocmd ColorScheme * highlight LineNr ctermbg=none
" カラースキーマのシンタックスを有効にする
syntax on
set term=xterm-256color
" vimで使える色を256色にする
set t_Co=256
" カーソルの行の数字の色
highlight LineNr ctermfg=215
" カーソルの行の数字のハイライトの色
highlight CursorLineNr ctermfg=yellow

""""""""""""""""""""""""""""""


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
vnoremap <S-h> ^
vnoremap <S-l> $

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

" ペイン分割
nnoremap <Space>v :<C-u>vsplit<CR>
nnoremap <Space>w :<C-u>split<CR>

" タブ分割
nnoremap <Space>t :<C-u>tabnew<CR>
nnoremap <Space>tw :<C-u>tabclose<CR>
""""""""""""""""""""""""""""""


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
	\	exe "normal! g'\"" |
	\ endif
endif
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" ペースト設定(ペースト時にインデントを入れないようにする)
""""""""""""""""""""""""""""""
if &term =~ "xterm"
	let &t_ti .= "\e[?2004h"
	let &t_te .= "\e[?2004l"
	let &pastetoggle = "\e[201~"

	function XTermPasteBegin(ret)
		set paste
		return a:ret
	endfunction

	noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
	inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
	cnoremap <special> <Esc>[200~ <nop>
	cnoremap <special> <Esc>[201~ <nop>
endif
""""""""""""""""""""""""""""
