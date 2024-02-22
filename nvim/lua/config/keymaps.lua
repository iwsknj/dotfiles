-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local discipline = require("utils.discipline")
discipline.cowboy()

local keymap = vim.keymap
keymap.set("i", "jj", "<ESC>", { noremap = true, desc = "jjでインサートモードを抜ける" })

keymap.set(
  "n",
  "+",
  "<Cmd>let @+ = @@<CR>",
  { noremap = true, desc = "レジスタ+に無名レジスタの文字列をコピー" }
)
