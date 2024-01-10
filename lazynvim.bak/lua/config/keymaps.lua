-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local discipline = require("utils.discipline")
discipline.cowboy()

local keymap = vim.keymap

-- 数字のインクリメント・デクリメント
keymap.set("n", "+", "<C-a>", { noremap = true, desc = "Increment" })
keymap.set("n", "-", "<C-x>", { noremap = true, desc = "Decrement" })

-- 画面分割
keymap.set("n", "<Leader>ss", ":split<Return>", { noremap = true, desc = "水平分割" })
keymap.set("n", "<Leader>sv", ":vsplit<Return>", { noremap = true, desc = "垂直分割" })

-- 画面移動
keymap.set("n", "<Leader>wh", "<C-w>h", { noremap = true, desc = "画面左に移動" })
keymap.set("n", "<Leader>wk", "<C-w>k", { noremap = true, desc = "画面上に移動" })
keymap.set("n", "<Leader>wj", "<C-w>j", { noremap = true, desc = "画面下に移動" })
keymap.set("n", "<Leader>wl", "<C-w>l", { noremap = true, desc = "画面右に移動" })

-- 画面サイズ調整
keymap.set("n", "<C-w><left>", "<C-w><", { noremap = true, desc = "画面サイズを左に調整" })
keymap.set("n", "<C-w><right>", "<C-w>>", { noremap = true, desc = "画面サイズを右に調整" })
keymap.set("n", "<C-w><up>", "<C-w>+", { noremap = true, desc = "画面サイズを上に調整" })
keymap.set("n", "<C-w><down>", "<C-w>-", { noremap = true, desc = "画面サイズを下に調整" })

keymap.set("i", "jj", "<ESC>", { noremap = true, desc = "jjでインサートモードを抜ける" })
keymap.set(
  "n",
  "dw",
  'vb"_d',
  { noremap = true, desc = "単語をバックスペース方向に削除するショートカット" }
)
keymap.set("n", "<C-a>", "gg<S-v>G", { noremap = true, desc = "全選択" })
keymap.set(
  "n",
  "<Leader>O",
  "O<Esc>^Da",
  { noremap = true, desc = "新しい行を追加し、インデントなしで上の行に移動する" }
)
keymap.set(
  "n",
  "<Leader>o",
  "o<Esc>^Da",
  { noremap = true, desc = "新しい行を追加し、インデントなしで下の行に移動する" }
)
