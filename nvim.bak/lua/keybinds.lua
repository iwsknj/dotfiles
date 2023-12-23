local keymap = vim.keymap
local opts = { noremap = true, silent = true }


-- 表示行単位で上下移動するように
keymap.set('n', 'j', 'gj')
keymap.set('n', 'k', 'gk')
keymap.set('n', '<Down>', 'gj')
keymap.set('n', '<Up>', 'gk')

-- 逆に普通の行単位で移動したい時のために逆の map も設定しておく
keymap.set('n', 'gj', 'j')
keymap.set('n', 'gk', 'k')

-- 数字のインクリメント・デクリメント
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- タブ
keymap.set("n", "tn", ":tabnew<CR>") -- 開く
keymap.set("n", "te", ":tabedit<CR>") -- 開く
keymap.set("n", "tc", ":tabclose<CR>") -- 閉じる
keymap.set("n", "<tab>", ":tabnext<CR>") -- 次のタブ
keymap.set("n", "<s-tab>", ":tabprev<CR>") -- 前のタブ

-- 画面分割
keymap.set("n", "<Leader>ss", ":split<Return>", opts) -- 水平分割
keymap.set("n", "<Leader>sv", ":vsplit<Return>", opts) -- 垂直分割

-- 画面移動
keymap.set("n", "<Leader>sh", "<C-w>h") -- 左
keymap.set("n", "<Leader>sk", "<C-w>k") -- 上
keymap.set("n", "<Leader>sj", "<C-w>j") -- 下
keymap.set("n", "<Leader>sl", "<C-w>l") -- 右

-- 画面サイズ調整
keymap.set("n", "<C-w><left>", "<C-w><") -- 左
keymap.set("n", "<C-w><right>", "<C-w>>") -- 右
keymap.set("n", "<C-w><up>", "<C-w>+") -- 上
keymap.set("n", "<C-w><down>", "<C-w>-") -- 下

keymap.set("n", "x", '"_x') -- xで削除してもクリップボードに入れない
keymap.set('i', 'jj', '<ESC>', { silent = true}) -- jjでインサートモードを抜ける
keymap.set('n', 'Y', 'y$', { noremap = true }) -- Yで行末までヤンクする
keymap.set("n", "dw", 'vb"_d') -- 単語をバックスペース方向に削除するショートカット
keymap.set("n", "<C-a>", "gg<S-v>G") -- 全選択
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts) -- 新しい行を追加し、インデントなしで上の行に移動する
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts) -- 新しい行を追加し、インデントなしで下の行に移動する

