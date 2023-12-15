# Neovimのチートシート

## デフォルトの機能

タブ
`tn` : タブを開く
`te` : タブを開く
`<tab>` : 次のタブ
`<s-tab>` : 前のタブ
`:tabs` : タブ一覧を開く

画面分割
`<leader>ss` : 水平分割
`<leader>sv` : 垂直分割

画面移動
`<leader>sh` : 左
`<leader>sk` : 上
`<leader>sj` : 下
`<leader>sl` : 右

`:map` : すべて確認
`:imap` : インサートモードだけ
`:nmap` : ノーマルモードだけ
`:vmap` : ヴィジュアルモードだけ
`:verbose nmap` : 定義元ファイル情報も表示

## phaazon/hop.nvim

単語や行にキーワードで移動するプラグイン

カスタマイズしたキーマップ↓
`<leader><leader>hw` => `:HopWord` : 任意の単語に移動する
`<leader><leader>hl` => `:HopLine` : 任意の行に移動する
`<leader><leader>hf [移動したい単語]` => `:HopChar1` : 任意の文字に移動する


## pope/vim-commentary

`gcc` : コメントアウト / 解除
`(visual mode) gc` : 選択している行をコメントアウト / 解除
`gcap` : 段落のコメントアウト


## kylechui/nvim-surround

例（`*`はカーソル一）
```
    Old text                    Command         New text
--------------------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words) : 単語をカッコで囲む
    *make strings               ys$"            "make strings" : カーソルから行末まで"で囲む
    [delete ar*ound me!]        ds]             delete around me! : 囲んでいる[]を削除
    remove <b>HTML t*ags</b>    dst             remove HTML tags : タグを削除
    'change quot*es'            cs'"            "change quotes" :  囲われている'を"に変える
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1> : タグをh1に変える
    delete(functi*on calls)     dsf             function calls : ファンクションを削除する
```

## nvim-telescope

`<leader>fP` : nvimのプラグインファイルを探す
`;f` : 現在のワーキングディレクトリ内のファイルを探す（.gitignoreのファイルは無視）
`;r` : 現在のワーキングディレクト内をテキストでgrepする（.gitignoreのファイルは無視）
`\\` : バッファのリストから探す
`;t` : 利用可能なヘルプタグを一覧表示し、<cr>に関連するヘルプ情報を新しいウィンドウで開く
`;;` : 前回実行したtelescopeを開く
`;e` : すべてのオープンバッファまたは特定のバッファの診断を一覧表示する
`;s` : Treesitterから関数や変数を抽出してリストで表示
`;b` : 現在のディレクトリからファイルをブラウジング
    `N` : 作成
    `R` : リネーム

